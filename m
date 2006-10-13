From: "Mathew Brown" <mathewbrown@fastmail.fm>
Subject: Re: Preventing ACPI from Damaging Your CPU
Date: Thu, 12 Oct 2006 21:41:15 -0700
Message-ID: <1160714475.18692.273233665@webmail.messagingengine.com>
References: <1160663160.13196.273175261@webmail.messagingengine.com>
   <20061013012430.GA31911@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56737 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750783AbWJMElP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Oct 2006 00:41:15 -0400
Content-Disposition: inline
In-Reply-To: <20061013012430.GA31911@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

Thanks Matthew.  Just out of curiosity, how did you find out about this
feature (forcing the fan at 80C)?  Also, is this specific to HP or do
other vendors also support this?  Finally, is 80C safe for the CPU
(Intel or AMD?)?  I read that Opteron chips could be damaged if their
temperature reaches 70C.  Thanks for your help.

On Fri, 13 Oct 2006 02:24:30 +0100, "Matthew Garrett"
<mjg59@srcf.ucam.org> said:
> On Thu, Oct 12, 2006 at 07:26:00AM -0700, Mathew Brown wrote:
> 
> >   I've been reading an alarming article on getting Gentoo to work on the
> >   HP Compaq nx6325
> >   (http://gentoo-wiki.com/HARDWARE_Gentoo_on_HP_Compaq_nx6325) and the
> >   serious ACPI problems that were encountered.  The author states after
> >   mentioning how to apply certain patches, "Without that, the CPU might
> >   overheat and get damaged during heavy load (such as compiling a Gentoo
> >   stage ...)!"
> 
> The author is wrong. Recent HP laptops all have hardcoded support in the 
> fan control hardware, which will force the fan on if the temperature 
> rises above 80 degrees.
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org
-- 
  Mathew Brown
  mathewbrown@fastmail.fm

-- 
http://www.fastmail.fm - mmm... Fastmail...

