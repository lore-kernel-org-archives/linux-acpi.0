From: "Karthik Gopalakrishnan" <karthik.g.krishnan@gmail.com>
Subject: Re: Where to find dmesg messages explanations ?
Date: Mon, 15 Jan 2007 08:24:44 +0530
Message-ID: <5e0a1fd80701141854h32e3ea69hf61a50501f598e3@mail.gmail.com>
References: <45AA1177.1000202@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:37934 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbXAOCyp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Jan 2007 21:54:45 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1612649wxd
        for <linux-acpi@vger.kernel.org>; Sun, 14 Jan 2007 18:54:45 -0800 (PST)
In-Reply-To: <45AA1177.1000202@free.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lecotegougdelaforce@free.fr
Cc: linux-acpi@vger.kernel.org

On 1/14/07, Goulven Guillard <lecotegougdelaforce@free.fr> wrote:
> Hi,
>
> Is there any place where I can find some explanations about dmesg
> messages and consequences of their causes (especially for acpi/apic/irq
> messages) ?

Strings printed out using the 'printk()' function in the kernel appear
in the dmesg output. The best place to find the explanation for a
particular message would be to figure out which printk() prints the
message & trace back to find the cause. There is no other
documentation AFAIK.

>
> Thanks.
>
>
> --
> La banquise fond !!! Adoptez un pingouin...
> => http://doc.ubuntu-fr.org/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
