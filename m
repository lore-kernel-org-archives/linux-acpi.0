From: Karol Kozimor <sziwan@hell.org.pl>
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
Date: Tue, 22 Feb 2005 15:33:22 +0100
Message-ID: <20050222143322.GA538@hell.org.pl>
References: <20050214211105.GA12808@elf.ucw.cz> <200502151742.55362.s0348365@sms.ed.ac.uk> <1108563926.4986.3.camel@localhost.localdomain> <200502182049.11088.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <200502182049.11088.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Kjartan Maraas <kmaraas@broadpark.no>, Lorenzo Colitti <lorenzo@colitti.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@suse.cz>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

Thus wrote Alistair John Strachan:
> I discovered that either the i2c_core.ko or i2c_i801.ko modules cause the hang 
> on resume! If you stop the entire i2c subsystem from being loaded by hotplug 
> (note this is the BUS driver, not the sensors driver!), then resume works 
> perfectly! Presumably there's a bug in the resuming of this module.

Might it be another instance of the LPC chip config space messed up on resume?
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
