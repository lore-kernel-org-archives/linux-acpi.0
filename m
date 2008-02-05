From: Len Brown <lenb@kernel.org>
Subject: Re: acer aspire 5315, Ubuntu 2.6.22-14-generic, ACPI Exception (processor_core-0783): AE_NOT_FOUND
Date: Tue, 5 Feb 2008 12:34:17 -0500
Message-ID: <200802051234.17442.lenb@kernel.org>
References: <de8605510801271842pc2a690dnd603c6b9faad88ec@mail.gmail.com> <200802040054.49916.lenb@kernel.org> <de8605510802040955v2b11ee4ai950f7cc3839f9148@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48637 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756742AbYBESWp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Feb 2008 13:22:45 -0500
In-Reply-To: <de8605510802040955v2b11ee4ai950f7cc3839f9148@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ibiltari <ibiltari@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Monday 04 February 2008 12:55, Ibiltari wrote:
> Hi, i have made some experiments, and yes i can confirm that
> (apparently) there is no difference with or without acpi_OSI=!linux,
> everything works the same and dmesg looks almost the same.
> 
> Thanks for your support
> 
> PD: I'm curious about something and i think you can answer, sorry if
> this is not the right place.
> 
> I normally get this error :
> [   19.553643] ACPI Exception (processor_core-0783): AE_NOT_FOUND,
> Processor Device is not present [20070126]
> 
> but everything works anyway 

Please look here:

http://bugzilla.kernel.org/show_bug.cgi?id=8570

thanks,
-Len
