From: Karol Kozimor <sziwan@hell.org.pl>
Subject: Re: [ACPI] Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 14:17:30 +0100
Message-ID: <20050215131730.GA22194@hell.org.pl>
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20050215125555.GD16394@gamma.logic.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Pavel Machek <pavel@suse.cz>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

Thus wrote Norbert Preining:
> vga=normal plus boot-radeon (webpage(5)) works to get text console
> back. But switching to X freezes the computer completely.
> 
> X from debian sid. 
> XFree86 Version 4.3.0.1 (Debian 4.3.0.dfsg.1-10 20041215174925 fabbione@fabbione.net)
> Release Date: 15 August 2003

Get a recent X version, 4.4, 6.7.0 or 6.8.2 will do. Alternatively, disable
DRI.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
