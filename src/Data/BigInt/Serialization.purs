module Data.BigInt.Serialization where

import Prelude

import Data.Array (replicate)
import Data.BigInt (BigInt, digitsInBase)
import Data.BigInt.Serialization.Alphabet (base58Alphabet, bech32Alphabet, hexAlphabet)
import Data.Maybe (fromJust)
import Data.String (fromCharArray)
import Data.String.NonEmpty (NonEmptyString, charAt, fromNonEmptyCharArray, length, prependString)
import Partial.Unsafe (unsafePartial)

serializeWithAlphabet :: NonEmptyString -> BigInt -> NonEmptyString
serializeWithAlphabet alphabet x =
  let l = length alphabet
  in  fromNonEmptyCharArray
      $ unsafePartial fromJust <<< flip charAt alphabet
        <$> (digitsInBase l x).value

serializeWithAlphabetToMinLength :: NonEmptyString -> Int -> BigInt -> NonEmptyString
serializeWithAlphabetToMinLength alphabet l x =
  let s = serializeWithAlphabet alphabet x
      l' = length s
  in  if l' < l
      then prependString (fromCharArray $ replicate (l - l') '0') s
      else s

serializeBase58 :: BigInt -> NonEmptyString
serializeBase58 = serializeWithAlphabet base58Alphabet

serializeBech32 :: BigInt -> NonEmptyString
serializeBech32 = serializeWithAlphabet bech32Alphabet

serializeHex :: BigInt -> NonEmptyString
serializeHex = serializeWithAlphabet hexAlphabet

serializeBase58ToMinLength :: Int -> BigInt -> NonEmptyString
serializeBase58ToMinLength = serializeWithAlphabetToMinLength base58Alphabet

serializeBech32ToMinLength :: Int -> BigInt -> NonEmptyString
serializeBech32ToMinLength = serializeWithAlphabetToMinLength bech32Alphabet

serializeHexToMinLength :: Int -> BigInt -> NonEmptyString
serializeHexToMinLength = serializeWithAlphabetToMinLength hexAlphabet
