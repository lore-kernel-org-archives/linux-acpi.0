From: John L Fjellstad <john-acpi@fjellstad.org>
Subject: problem compiling intel ASL compiler
Date: Sun, 23 Apr 2006 21:19:54 -0700
Message-ID: <87k69fppud.fsf@fjellstad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-jp
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41118 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750797AbWDXFkI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Apr 2006 01:40:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FXtnl-0008JL-Qv
	for linux-acpi@vger.kernel.org; Mon, 24 Apr 2006 07:40:01 +0200
Received: from mail.fjellstad.org ([209.128.86.70])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 24 Apr 2006 07:40:01 +0200
Received: from john-acpi by mail.fjellstad.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 24 Apr 2006 07:40:01 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm trying to compile Intel's ASL compiler dated 20060331, but have
problems.  Get this error message:

aslcompiler.l: In function =A1=C6comment=A1=C7:
aslcompiler.l:848: error: =A1=C6yytext_ptr=A1=C7 undeclared (first use =
in this function)
aslcompiler.l:848: error: (Each undeclared identifier is reported only =
once
aslcompiler.l:848: error: for each function it appears in.)
make: *** [aslcompilerlex.o] Error 1

gcc version: gcc (GCC) 4.0.3 (Ubuntu 4.0.3-1ubuntu5)
flex version: flex 2.5.31
bison version: bison (GNU Bison) 2.1

Don't really know enough about flex to fix the problem.  Anyone have an
idea?

--=20
John L. Fjellstad
web: http://www.fjellstad.org/          Quis custodiet ipsos custodes

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
