From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger@gmx.at>
Subject: Re: [ACPI] Call for help: list of machines with working S3
Date: Wed, 16 Feb 2005 09:48:42 +0100
Message-ID: <200502160948.43005.stefandoesinger@gmx.at>
References: <20050214211105.GA12808@elf.ucw.cz> <e796392205021521541da7ee25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <e796392205021521541da7ee25@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: acpi-devel@lists.sourceforge.net, Stefan Schweizer <sschweizer@gmail.com>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org


> The problems with this patch are:
> - you need to press a key to come back from the "resume-console" after
> resume. - DRI in X does not work (at least for me with intel-agp, others
> reportet it works)
> I just disabloed it by not loading intel-agp (hotplug-blacklist)
You can force the radeon X driver to use pci mode by setting Option 
"ForcePciMode" to "true" or something simmilar in you X config file. This way 
you can get dri without intel-agp. This is much slower, but enought to play 
tuxracer ;-)

Stefan
