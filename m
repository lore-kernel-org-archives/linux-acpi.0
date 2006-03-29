From: glen martin <lists@locutory.org>
Subject: Re: no /proc/acpi, trying to dump dsdt to a file
Date: Wed, 29 Mar 2006 10:49:30 -0800
Message-ID: <442AD6BA.8070903@locutory.org>
References: <971FCB6690CD0E4898387DBF7552B90E04D4B14E@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m198-163.dsl.rawbw.com ([198.144.198.163]:24046 "EHLO
	slowpoke.locutory.org") by vger.kernel.org with ESMTP
	id S1750949AbWC2Sta (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Mar 2006 13:49:30 -0500
Received: from [127.0.0.1] (slowpoke.locutory.org [192.168.0.126])
	by slowpoke.locutory.org (Postfix) with ESMTP id 914021C067
	for <linux-acpi@vger.kernel.org>; Wed, 29 Mar 2006 10:49:29 -0800 (PST)
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E04D4B14E@orsmsx403.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Yeah, no problem at all. What, Windows care about a broken dsdt? Bah ... :)

A number of folks have run into this dsdt problem with this and related
boards from ASUS. The instructions on how to deal suggest dumping and
fixing the dsdt table,or grabbing a pre-fixed one from the repository on
SF.  I tried the repository, but the iasl compiler won't deal with it,
so the next attempt was to dump and fix my existing broken table from
the BIOS.

Thanks,

glen


Moore, Robert wrote:

>Does this machine boot Windows ok?
>  
>
>>-----Original Message-----
>>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>>owner@vger.kernel.org] On Behalf Of glen martin
>>Sent: Wednesday, March 29, 2006 9:51 AM
>>...
>>kernel is 2.6.15, with gentoo patches and the patch to load a dsdt from initrd.
>>
>>I'm trying to dump my dsdt, but there is no /proc/acpi, let alone
>>/proc/acpi/dsdt.
>>
>>Is there something special needed to make /proc/acpi show up? Or other
>>way to get at the existing dsdt in this situation?
>>    
>>
<snip>

