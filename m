From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: How to disable power managment for SATA?
Date: Mon, 31 May 2010 18:06:10 -0600
Message-ID: <4C044EF2.8000109@gmail.com>
References: <AANLkTilxYC8a88DwMlc6MPgM_ai9we9vsCXej-KqwToY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46297 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab0FAAGM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 May 2010 20:06:12 -0400
Received: by iwn6 with SMTP id 6so608470iwn.19
        for <linux-acpi@vger.kernel.org>; Mon, 31 May 2010 17:06:11 -0700 (PDT)
In-Reply-To: <AANLkTilxYC8a88DwMlc6MPgM_ai9we9vsCXej-KqwToY@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Fred ." <eldmannen@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 05/31/2010 05:38 PM, Fred . wrote:
> I can disable power management with acpi=off
>
> But how do I disable it just for SATA?

acpi=off will disable many other things as well which you probably don't 
want, what are you trying to disable specifically?

Link power management isn't normally on by default for SATA, unless your 
distro turned it on. Have a look at what's in the files found by:

find /sys -name link_power_management_policy
