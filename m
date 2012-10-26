From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH] Enable A20 using KBC for some MSI laptops to fix S3 resume
Date: Thu, 25 Oct 2012 22:31:43 -0600
Message-ID: <508A122F.3090304@gmail.com>
References: <201210240847.52417.linux@rainbow-software.org> <450396555.xT2D53NWjT@vostro.rjw.lan> <5e64035c-9ee0-4e76-a348-d4f9f6c7b198@email.android.com> <20121024210941.3c7d2cfb@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44922 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab2JZEbq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Oct 2012 00:31:46 -0400
In-Reply-To: <20121024210941.3c7d2cfb@pyramind.ukuu.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Ondrej Zary <linux@rainbow-software.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/24/2012 02:09 PM, Alan Cox wrote:
> On Wed, 24 Oct 2012 12:36:04 -0700
> "H. Peter Anvin" <hpa@zytor.com> wrote:
>
>> Minor concern: it should do the wait for ready before sending each command.
>
> Can we get a command line to do this quirk too - it strikes me that if
> the MSIs rely upon it then it may be something Windows always does so
> will be useful to try on other problem machines as an experiment.

I agree, one has to keep in mind the age-old question "how does Windows 
work?" since it surely has no such quirk. I'd say we're sometimes too 
quick to add these DMI quirks when a more general solution would be 
somehow figure out how the Linux behavior differs from what Windows is 
doing.

