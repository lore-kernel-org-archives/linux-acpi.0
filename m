From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: enabling aspm on ati radeon
Date: Fri, 17 May 2013 14:04:42 -0400
Message-ID: <5196713A.1010102@ubuntu.com>
References: <519443A1.8050905@ubuntu.com> <1995989.Fff0uGKnZO@vostro.rjw.lan> <CAErSpo50rX5Pvj=pX5xsdcZ1qq1C7kBqrNyDmY6t26OCVqbxXA@mail.gmail.com> <5195596C.3000406@ubuntu.com> <CAErSpo6wSgquzJc22tFJozp8cfx0vpULnO3KZN2gr2YHt8EHrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo6wSgquzJc22tFJozp8cfx0vpULnO3KZN2gr2YHt8EHrw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 5/17/2013 1:31 PM, Bjorn Helgaas wrote:
> You also have this bridge where lspci says "ASPM unknown":
> 
> 00:01.0 bridge to [bus 01] ASPM unknown
> 
> Just out of curiosity, can you collect the output of "lspci -xxxs 
> 00:01.0"?  There are only two bits in the Link Capabilities ASPM 
> support field, and all four encodings are defined, so I'm curious 
> about why lspci says "unknown".

I'll get that as soon as I get home, but why would the ASPM status of
the root complex have anything to do with the rest of the devices?
Enabling ASPM on one link doesn't require it to be enabled on all
upstream links does it?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJRlnE6AAoJEJrBOlT6nu75nWUIAI7iOcoOklDWhS1FriQJmXTm
X8OJ4VZB8VVPeIuzrW+I6sppUrxqpnnxvrJT7Trnh5SDwwJjwx3m6BVrZHphrlCN
armoZ5jLSuBS9mn4mpeAOfUS7uypAuyL4fEo6DYJa9fPZycL1LukjkuwZMRJ+bfw
sjXQ7soHC52r2wxWhDHZbOl9UEWtYHhBypoI+PpYMO00lQp3gGnJXedm2zHti+a3
2ZtIieydLw++nXDr18WxDbJ5h1rQi626rVip0IcO6VUhhNxcd8hzGFkRAc7vNodw
bjW6wp8f+sddfX5uHkh9zYzwaEblLgBkxqw93xzRdh1ujJHet4R/jL1NTLZ8EZY=
=W4Uc
-----END PGP SIGNATURE-----
