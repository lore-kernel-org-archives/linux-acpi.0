From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 15:41:23 +0000
Message-ID: <1108482083.12031.10.camel@elrond.flymine.org>
References: <20050214211105.GA12808@elf.ucw.cz>
	 <200502150605.11683.s0348365@sms.ed.ac.uk>  <4211E729.1090305@colitti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <4211E729.1090305@colitti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Colitti <lorenzo@colitti.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>, Pavel Machek <pavel@suse.cz>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-02-15 at 13:12 +0100, Lorenzo Colitti wrote:

> I beg to differ: it works for me on 2.6.11-rc3 (even with the swsusp2 
> patch). However, I need to use acpi_sleep=s3_bios, and I can't use 
> radeonfb or it will lock up on resume.

Could you grab dmidecode from http://www.nongnu.org/dmidecode/ and
provide the output? It'd be interesting to compare working with
non-working machines. It might also be good to see lspci and acpidmp
output.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
