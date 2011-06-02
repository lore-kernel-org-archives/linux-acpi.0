From: Azael Avalos <coproscefalo@gmail.com>
Subject: Re: ACPI support for Toshiba Satellite Pro L770-116 Update
Date: Wed, 1 Jun 2011 20:56:31 -0600
Message-ID: <BANLkTin+yN6MAxC5+po8R2cjUorNe86ACA@mail.gmail.com>
References: <4DE68096.7040708@mitterfellner.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46733 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759290Ab1FBC4c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jun 2011 22:56:32 -0400
Received: by bwz15 with SMTP id 15so570437bwz.19
        for <linux-acpi@vger.kernel.org>; Wed, 01 Jun 2011 19:56:31 -0700 (PDT)
In-Reply-To: <4DE68096.7040708@mitterfellner.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Mitterfellner <thomas@mitterfellner.at>
Cc: linux-acpi@vger.kernel.org

Hi

Basically, the following errors appear everytime an Fn-FX combo is made

ACPI Error: Result stack is empty! State=3Dffff8801eb0a7800 (20101013/d=
swstate-98)
ACPI Exception: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20101013/dsutils-646)
ACPI Exception: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20101013/dsutils-763)
ACPI Error: Method parse/execution failed [\_SB_.VALZ.GETE] (Node
ffff880225d76420), AE_AML_NO_RETURN_VALUE (20101013/psparse-537)
ACPI Error: Method parse/execution failed [\_SB_.VALZ.INFO] (Node
ffff880225d763f8), AE_AML_NO_RETURN_VALUE (20101013/psparse-537)


I=C2=B4m not quite sure if this is a kernel or BIOS bug (or both).

As far as I understand, the method is queried but nothing is returned..=
=2E

Or maybe I=C2=B4m misunderstanding something.


Saludos
Azael Avalos


--=20
-- El mundo apesta y vosotros apestais tambien --
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
