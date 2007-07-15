From: Dirk Partikel <dirk.partikel@gmx.de>
Subject: Error 4049
Date: Sun, 15 Jul 2007 12:19:01 +0200
Message-ID: <4699F495.8030603@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:54167 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757434AbXGOKPH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Jul 2007 06:15:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,
can someone help me to fix this error?

dsdt.dsl  7202:         WBYT (TSAD, 0x4F, Local0)
Error    4049 -                                ^ Method local variable 
is not initialized (Local0)

Best Regards
Dirk Partikel

Part of dsdt:
    Method (STOS, 3, NotSerialized)
    {
        WBYT (TSAD, 0x4F, 
Local0)                                         Ln 7202
    }

    Method (STHY, 3, NotSerialized)
    {
        WBYT (TSAD, 0x4F, Arg1)
    }


