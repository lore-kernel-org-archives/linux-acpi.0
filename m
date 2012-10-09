From: Len Brown <lenb@kernel.org>
Subject: Re: [bisected] PS/2 keyboard and mouse dead on resume on Intel D845BG
Date: Tue, 09 Oct 2012 01:11:55 -0400
Message-ID: <5073B21B.4090600@kernel.org>
References: <201210071513.27959.linux@rainbow-software.org> <201210072100.09813.linux@rainbow-software.org> <20121008144243.GC5068@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56622 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab2JIFL6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Oct 2012 01:11:58 -0400
In-Reply-To: <20121008144243.GC5068@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Ondrej Zary <linux@rainbow-software.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 10/08/2012 10:42 AM, Matthew Garrett wrote:
> On Sun, Oct 07, 2012 at 09:00:09PM +0200, Ondrej Zary wrote:
> 
>> Added acpi_read_bit_register there and it seems that SCI_EN is already set!
>>
>> This patch fixes the problem here. I wonder how this affects systems that
>> require SCI_EN to be set.
> 
> I /think/ that this will be safe, but it doesn't match my recollection 
> of how Windows behaves so it may break something. Any chance you can 
> find someone with one of the machines mentioned in 
> https://bugzilla.kernel.org/show_bug.cgi?id=13745 and make sure that 
> they still work with your patch?

yikes.
we started with a white-list,
then we made setting SCI_EN the default,
and here is at least one box that wants to be on a black list
so that we don't set SCI_EN:-(



