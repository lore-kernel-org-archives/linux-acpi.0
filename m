From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Auto load of coretemp and pkgtemp
Date: Tue, 25 Jan 2011 18:45:28 -0600
Message-ID: <4D3F6EA8.4030503@gmail.com>
References: <4D3DBCC9.7000804@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53377 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab1AZApb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jan 2011 19:45:31 -0500
Received: by iyj18 with SMTP id 18so5677172iyj.19
        for <linux-acpi@vger.kernel.org>; Tue, 25 Jan 2011 16:45:30 -0800 (PST)
In-Reply-To: <4D3DBCC9.7000804@cfl.rr.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-acpi@vger.kernel.org

On 01/24/2011 11:54 AM, Phillip Susi wrote:
> I recently built a new sandybridge system and was surprised to find that
> I had to manually load the coretemp and pkgtemp modules to monitor the
> cpu temperature.  My last few systems have been AMD where the k8temp
> module is automatically loaded.  It seems k8temp has a modalias that
> gets it loaded on the correct hardware, but coretemp and pkgtemp have no
> alias.  Why is this, and how can I construct a proper alias to get the
> intel modules to auto load?

I think the difference is that on AMD the temperature monitoring is done 
through a virtual PCI device that we can make a modalias for, but 
coretemp support is based on CPUID and I don't think there's a way to 
construct a modalias for that.
