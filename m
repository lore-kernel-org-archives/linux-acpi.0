From: "Salatiel Filho" <salatiel.filho@gmail.com>
Subject: acpi_serialize lock kernel 2.6.21-rc3
Date: Sat, 10 Mar 2007 16:42:48 -0300
Message-ID: <beb91d720703101142q7e82cf8dt392eb932d12b1813@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:9781 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091AbXCJTmv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Mar 2007 14:42:51 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1733572uga
        for <linux-acpi@vger.kernel.org>; Sat, 10 Mar 2007 11:42:49 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Is anyone having problems with acpi_serialize in kernel 2.6.21-rc3 ?
Kernel locks during boot when i use acpi_serialize, and i need it to
acpi function properly on my laptop. It worked fine in 2.6.20.

Any help ?


--=20
[]'s
Salatiel

"O maior prazer do inteligente =E9 bancar o  idiota
   diante de um  idiota que banca o inteligente".
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
