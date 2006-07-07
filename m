From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Subject: Re: [patch 2/6] ACPI: Atlas ACPI driver
Date: Fri, 7 Jul 2006 11:49:21 -0400
Message-ID: <756b48450607070849v68a5495dg2b4503e9b9b5ba37@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6E16BE4@hdsmsx411.amr.corp.intel.com>
	 <756b48450607020443i3e2c6c16m2b3f8666b53fd5c@mail.gmail.com>
	 <d120d5000607070844n41bdd00fkad5bd3c996b699f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:59370 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932114AbWGGPtX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jul 2006 11:49:23 -0400
Received: by ug-out-1314.google.com with SMTP id a2so3138399ugf
        for <linux-acpi@vger.kernel.org>; Fri, 07 Jul 2006 08:49:22 -0700 (PDT)
In-Reply-To: <d120d5000607070844n41bdd00fkad5bd3c996b699f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, akpm@osdl.org, linux-acpi@vger.kernel.org, "Yu, Luming" <luming.yu@intel.com>

On 7/7/06, Dmitry Torokhov <dmitry.torokhov@gmail.com>
> I think because the driver would be new for the mainline we should
> remove the old way of  reporting events and rely on input layer (and
> make the driver depend on CONFIG_INPUT).
>
> Also, could you please change phys from "acpi/input0" to something
> like "ASIM0000/atlas/input0" to make it more unique?
>

Agreed. Will do all three.

Thanks,
jaya
