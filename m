From: Mattia Dongili <malattia@linux.it>
Subject: Re: no brightness with acpi video since 3.3 [was Re: Issues with the
 sony-platform module]
Date: Fri, 15 Jun 2012 20:36:38 +0900
Message-ID: <20120615113637.GA5904@kamineko.org>
References: <4FDA2051.3050108@babioch.de>
 <20120614203914.GA2645@kamineko.org>
 <4FDAE7FE.5030706@babioch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4FDAE7FE.5030706@babioch.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Karol Babioch <karol@babioch.de>
Cc: platform-driver-x86@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 15, 2012 at 09:45:02AM +0200, Karol Babioch wrote:
> Hi,
> 
> it seems that the first version was blocked due to the attachments,
> which were quite big, so I'm resending this without any attachments this
> time. You'll find links to the files over on pastebin.mozilla.org.
> 
> Am 14.06.2012 22:39, schrieb Mattia Dongili:
> > You can boot with acpi_backlight=vendor and get brightness control back
> > but the issue with acpi_video remains.
> Unfortunately that doesn't work either . According to the dmesg output
> the key presses itself get registered by the sony_module in both cases.
> However when booting with acpi_backlight=vendor I don't get any
> brightness control at all, whereas when booting without it the

you are running a 3.3 kernel with the latest sony-laptop patches, right?
if so you will need this bug fix to get brightness control back:
http://www.mail-archive.com/platform-driver-x86@vger.kernel.org/msg03294.html

could you please test it?

Thanks
-- 
mattia
:wq!
