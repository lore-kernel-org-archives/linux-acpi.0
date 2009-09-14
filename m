From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/5] acpi: fix trivial warning
Date: Mon, 14 Sep 2009 17:34:55 +0300
Message-ID: <94a0d4530909140734q51779b76g2ddc7211ece87171@mail.gmail.com>
References: <1252870707-4824-1-git-send-email-felipe.contreras@gmail.com>
	 <1252870707-4824-2-git-send-email-felipe.contreras@gmail.com>
	 <1252870707-4824-3-git-send-email-felipe.contreras@gmail.com>
	 <1252870707-4824-4-git-send-email-felipe.contreras@gmail.com>
	 <1252870707-4824-5-git-send-email-felipe.contreras@gmail.com>
	 <1252936556.28368.215.camel@desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:7685 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755590AbZINOex convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2009 10:34:53 -0400
In-Reply-To: <1252936556.28368.215.camel@desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Walker <dwalker@fifo99.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org

On Mon, Sep 14, 2009 at 4:55 PM, Daniel Walker <dwalker@fifo99.com> wro=
te:
> On Sun, 2009-09-13 at 22:38 +0300, Felipe Contreras wrote:
>> drivers/acpi/acpica/tbfadt.c: In function =E2=80=98acpi_tb_create_lo=
cal_fadt=E2=80=99:
>> arch/x86/include/asm/string_32.h:74: warning: array subscript is abo=
ve array bounds
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> Could you run this through checkpatch also, it looks like you have a =
few
> style issues..

I did... the style issues are already there, my patch is not
introducing them. Do you want me to send a separate patch to fix the
existing style issues?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
