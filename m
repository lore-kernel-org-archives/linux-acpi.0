From: Eric Valette <eric.valette-GANU6spQydw@public.gmane.org>
Subject: [Fwd: [Bug 2403] New: ACPI error with 20040326 version]
Date: Wed, 31 Mar 2004 21:39:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <406B1E85.2020805@free.fr>
Reply-To: eric.valette-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010400020101050908060400"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010400020101050908060400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette-GANU6spQydw@public.gmane.org




--------------010400020101050908060400
Content-Type: message/rfc822;
 name="[Bug 2403] New: ACPI error with 20040326 version"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[Bug 2403] New: ACPI error with 20040326 version"

Return-Path: <www-3NddpPZAyC0@public.gmane.org>
Delivered-To: online.fr-eric.valette-GANU6spQydw@public.gmane.org
Received: (qmail 18068 invoked from network); 31 Mar 2004 13:32:30 -0000
Received: from fire.osdl.org (HELO fire-2.osdl.org) (65.172.181.4)
  by mrelay5-1.free.fr with SMTP; 31 Mar 2004 13:32:30 -0000
Received: from fire-2.osdl.org (localhost [127.0.0.1])
	by fire-2.osdl.org (8.12.8/8.12.8) with ESMTP id i2VDWOWf003537
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <eric.valette-GANU6spQydw@public.gmane.org>; Wed, 31 Mar 2004 05:32:24 -0800
Received: (from www-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org)
	by fire-2.osdl.org (8.12.8/8.12.5/Submit) id i2VDWO0u003529;
	Wed, 31 Mar 2004 05:32:24 -0800
Date: Wed, 31 Mar 2004 05:32:24 -0800
Message-Id: <200403311332.i2VDWO0u003529-pT9G7ROwbuBb5UGfqNBoRg@public.gmane.org>
From: bugme-daemon-3NddpPZAyC0@public.gmane.org
To: eric.valette-GANU6spQydw@public.gmane.org
Subject: [Bug 2403] New: ACPI error with 20040326 version
X-Bugzilla-Reason: Reporter
X-Bugzilla-Category: ACPI
X-Bugzilla-Component: AML-Interpreter
X-Spam-Status: No, hits=1.088 required=5 tests=NO_REAL_NAME
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.4__
X-MIMEDefang-Filter: osdl$Revision: 1.55 $
X-Scanned-By: MIMEDefang 2.36

http://bugme.osdl.org/show_bug.cgi?id=2403

           Summary: ACPI error with 20040326 version
    Kernel Version: 2.6.5-rc3-mm2
            Status: NEW
          Severity: normal
             Owner: acpi_aml-interpreter-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
         Submitter: eric.valette-GANU6spQydw@public.gmane.org


Distribution:
Hardware Environment: Asus A7V. Previously working like a charm
Software Environment: Debian sid
Problem Description: New erros leading to non functionnal power button soft off

Steps to reproduce: Boot linux 2.6.5-rc3-mm2 on an A7V board with BIOS 1011

ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
    ACPI-1133: *** Error: Method execution failed [\SPRW] (Node dffd9220),
AE_NOT_EXIST
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0._PRW] (Node
dff64720), AE_NOT_EXIST
    ACPI-0154: *** Error: Method execution failed [\_SB_.PCI0._PRW] (Node
dff64720), AE_NOT_EXIST
ACPI: Interpreter enabled

------- You are receiving this mail because: -------
You reported the bug, or are watching the reporter.

--------------010400020101050908060400--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
