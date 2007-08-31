From: Carlos Corbacho <cathectic@gmail.com>
Subject: Re: wmi.c - Any news?
Date: Fri, 31 Aug 2007 21:00:20 +0100
Message-ID: <200708312100.20753.cathectic@gmail.com>
References: <200708301003.41489.cathectic@gmail.com> <200708311423.50178.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:54383 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbXHaT65 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Aug 2007 15:58:57 -0400
Received: by nf-out-0910.google.com with SMTP id f5so784683nfh
        for <linux-acpi@vger.kernel.org>; Fri, 31 Aug 2007 12:58:55 -0700 (PDT)
In-Reply-To: <200708311423.50178.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Friday 31 August 2007 19:23:50 Len Brown wrote:
> Do you have other acer-specific functions which are not related to WMI?

We currently poke about a bit at registers on the EC to read (and sometimes 
write) a few values which are not available through WMI (but only on a 
handful of laptops, where someone has actually gathered the data on and 
passed back to me). 

On older laptops, this is so we can control the brightness and read 'real' 
values for the state of the wireless, bluetooth and Mail LED. On newer 
laptops, this is the only way to control the Mail LED at all (but this is all 
as a compliment to the functionality exposed through WMI - I have no 
intention of producing a generic 'acer-laptop' driver to control all the 
non-WMI laptops as well).

-Carlos
-- 
E-Mail: cathectic@gmail.com
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
