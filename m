From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: AML method concurrency
Date: Wed, 30 May 2007 11:37:40 +0400
Message-ID: <465D29C4.20707@gmail.com>
References: <200705291454.27905.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:4402 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbXE3HkI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 May 2007 03:40:08 -0400
Received: by ug-out-1314.google.com with SMTP id j3so122529ugf
        for <linux-acpi@vger.kernel.org>; Wed, 30 May 2007 00:40:06 -0700 (PDT)
In-Reply-To: <200705291454.27905.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>

There is a "limited concurrency" in interpreter.
There is a "executor" semaphore(acpi_ex_{enter/exit}_interpreter), which
prevents generic concurrent execution of methods, but in the case of the
method blocking (mutex or sleep) it will be released and reacquired
after, thus allowing some other method to run during block.

Hope that helps,
Alex.

Bjorn Helgaas ?????:
> Can AML methods be executed concurrently?
> 
> The existence of mutexes, serialized methods, and the Linux
> "acpi_serialize" parameter makes me think that in general, we
> should be able to execute multiple AML methods concurrently.
> 
> However, the ACPI CA Programmer Reference, rev 1.16, section 2.2.5,
> says:
> 
>   The specification states that at most one control method can be
>   actually executing AML code at any given time.  ...  it can be
>   said that the specification precludes the concurrent execution
>   of control methods.
> 
> It is referring to the ACPI specification, but I don't see any
> explicit statement there.  I've been pointed to this text from
> ACPI 3.0, section 5.5.2:
> 
>   Interpretation of a Control Method is not preemptive, but it can
>   block.  When a control method does block, the operating software
>   can initiate or continue the execution of a different control
>   method.
> 
> But this doesn't actually say anything about concurrency.
> 
> If ACPI does in fact preclude concurrent method execution, can you
> point me to discussion of this in the ACPI spec?
> 
> Bjorn
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

