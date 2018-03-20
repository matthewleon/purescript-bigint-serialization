module Data.BigInt.Serialization.Alphabet where

import Data.String.NonEmpty (NonEmptyString, unsafeFromString)
import Partial.Unsafe (unsafePartial)

base58Alphabet :: NonEmptyString
base58Alphabet = nes "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"

bech32Alphabet :: NonEmptyString
bech32Alphabet = nes "qpzry9x8gf2tvdw0s3jn54khce6mua7l"

hexAlphabet :: NonEmptyString
hexAlphabet = nes "0123456789abcdef"

nes :: String -> NonEmptyString
nes = unsafePartial unsafeFromString
