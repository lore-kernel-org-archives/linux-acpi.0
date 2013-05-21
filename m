From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: enabling aspm on ati radeon
Date: Tue, 21 May 2013 09:31:37 -0400
Message-ID: <519B7739.1040909@ubuntu.com>
References: <519443A1.8050905@ubuntu.com> <5196D765.9020600@ubuntu.com> <CAErSpo6MGwHLJvis+4=vdQEJN=Qb9aC5e9=3Q6MdTB-HH84YBw@mail.gmail.com> <11045555.dLhhFPGoSV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <11045555.dLhhFPGoSV@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 5/20/2013 4:01 PM, Rafael J. Wysocki wrote:
> I'm pretty sure it's measurable, at least in some cases.  Phoronix
> did quite some fuss about a commit that caused ASPM to not work any
> more on some systems some time ago, so he had to be able to measure
> it (and it was called a "major power regression").

That is why I was trying to get it enabled, but the "major regression"
seems to be caused by Radeons using the ASPM as a cue to enter low
power mode.  The energy saved by the bus itself going into the lower
power state I can't imagine is more than a few mW.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJRm3c5AAoJEJrBOlT6nu75MkUH/3qGUjM3BmDFjCJ5kJUaMOCg
Ps3YFcr37JPumLZNLAwAHeL+eZH1v8G1SkDKPFMfPjIMCY4II4xxthFutV6bslQv
PR5w5jjAg/qk0YXEq8CddhdZkVkJw8nKBZiN6jFFcn/c1UgFN39FHCzUTa3sMG2X
+rEM4RHzrtcIJm46KXkI162Dzcnj7UaGTFYUzwMCxzy3XHn8xKMS1tfsM1TW3sqS
ptcqbsy1rObJewAhdnQZ0pzRgLC7zKWkGlLo00JdFW7wChjsVbM2db++FlpkCT0W
sHSSEEYLFqef+fU9FHptJklMx31nF8QHDGh3S277YqTuIaanMufo+gx4vHJC3tM=
=tcAW
-----END PGP SIGNATURE-----
