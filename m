From: "Guillermo Bonvehi" <gbonvehi@gmail.com>
Subject: Re: dmidecode
Date: Fri, 13 Jul 2007 17:15:52 -0300
Message-ID: <835b805b0707131315n204d12a4k93375e2a8e801e18@mail.gmail.com>
References: <835b805b0707120457l72ba2a5cmb5970418d771dabe@mail.gmail.com>
	 <200707131539.00276.lenb@kernel.org>
	 <835b805b0707131312x7ea74f3frf4db47a56f07b358@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.180]:2152 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756765AbXGMUPx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jul 2007 16:15:53 -0400
Received: by ik-out-1112.google.com with SMTP id b32so458186ika
        for <linux-acpi@vger.kernel.org>; Fri, 13 Jul 2007 13:15:52 -0700 (PDT)
In-Reply-To: <835b805b0707131312x7ea74f3frf4db47a56f07b358@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi Len, you're welcome. dmidecode and acpidump gives the same output
using acpi_osi=!Linux parameter. I attached the dumps you requested.
If there's anything else I can do to help you let me know.

Best regards,
   Guillermo Bonvehi

On 7/13/07, Len Brown <lenb@kernel.org> wrote:
>
> Thanks, this is because of the acpi_osi=!Linux message?
> Did you try acpi_osi=!Linux and notice any difference?
>
> If you send along the output from acpidump, or better yet,
> attach it to a bug report (say this one
> http://bugzilla.kernel.org/show_bug.cgi?id=7787
>
> then i can peek at what HP is doing on this box and get a good idea
> if they should be on the white-list or on the blacklist.
>
> thanks,
> -Len
>
