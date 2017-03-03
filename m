From: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Subject: acpidbg: disassemble produces no output
Date: Fri, 3 Mar 2017 11:52:06 +0100
Message-ID: <adef7279-2036-93ac-eeef-8f2bc8c412e3@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.166]:31532 "EHLO
        mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751050AbdCCKwU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2017 05:52:20 -0500
Received: from r01ukexcasm215.r01.fujitsu.local (ex2k13_215.fs.fujitsu.com [10.182.185.117])
        by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id v23AnI52002006
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <linux-acpi@vger.kernel.org>; Fri, 3 Mar 2017 10:49:18 GMT
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Compiled Linux 4.10.0 on Fedora 25 and also build the ACPI debugger.

When I try

disassemble <method>

in acpidbg it does not produce any output. Same is true
for

debug <method>

which does not show the disassembled next instruction.

What am I missing? Any userland libs? acpica-tools are installed an
working, here I can disassemble without problems, but not in acpidbg.

Thanks for hints
Rainer
-- 
Dipl.-Inf. (FH) Rainer Koenig
Project Manager Linux Clients
FJ EMEIA PR PSO PM&D CCD ENG SW OSS&C

Fujitsu Technology Solutions
Bürgermeister-Ullrich-Str. 100
86199 Augsburg
Germany

Telephone: +49-821-804-3321
Telefax:   +49-821-804-2131
Mail:      mailto:Rainer.Koenig@ts.fujitsu.com

Internet         ts.fujtsu.com
Company Details  ts.fujitsu.com/imprint.html
