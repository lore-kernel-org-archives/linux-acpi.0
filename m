From: Daniel Walker <dwalker@fifo99.com>
Subject: Re: [PATCH 4/5] acpi: fix trivial warning
Date: Mon, 14 Sep 2009 06:55:56 -0700
Message-ID: <1252936556.28368.215.camel@desktop>
References: <1252870707-4824-1-git-send-email-felipe.contreras@gmail.com>
	 <1252870707-4824-2-git-send-email-felipe.contreras@gmail.com>
	 <1252870707-4824-3-git-send-email-felipe.contreras@gmail.com>
	 <1252870707-4824-4-git-send-email-felipe.contreras@gmail.com>
	 <1252870707-4824-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fifo99.com ([67.223.236.141]:52895 "EHLO fifo99.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbZINNzJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Sep 2009 09:55:09 -0400
In-Reply-To: <1252870707-4824-5-git-send-email-felipe.contreras@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org

On Sun, 2009-09-13 at 22:38 +0300, Felipe Contreras wrote:
> drivers/acpi/acpica/tbfadt.c: In function =E2=80=98acpi_tb_create_loc=
al_fadt=E2=80=99:
> arch/x86/include/asm/string_32.h:74: warning: array subscript is abov=
e array bounds
>=20
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Could you run this through checkpatch also, it looks like you have a fe=
w
style issues..

Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
