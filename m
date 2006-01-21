From: =?ISO-8859-1?Q?Mathieu_B=E9rard?= <Mathieu.Berard@crans.org>
Subject: linux-2.6.16-rc1-mm2: new ACPI errors
Date: Sat, 21 Jan 2006 19:31:27 +0100
Message-ID: <43D27DFF.2030104@crans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp6-g19.free.fr ([212.27.42.36]:3491 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S932232AbWAUSba (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Jan 2006 13:31:30 -0500
Received: from perenold.hd.free.fr (vbo91-2-82-239-207-88.fbx.proxad.net [82.239.207.88])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 12AB315833
	for <linux-acpi@vger.kernel.org>; Sat, 21 Jan 2006 19:31:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by perenold.hd.free.fr (Postfix) with ESMTP id 95162753
	for <linux-acpi@vger.kernel.org>; Sat, 21 Jan 2006 19:31:28 +0100 (CET)
Received: from perenold.hd.free.fr ([127.0.0.1])
	by localhost (perenold.hd.free.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 31516-10 for <linux-acpi@vger.kernel.org>;
	Sat, 21 Jan 2006 19:31:28 +0100 (CET)
Received: from localhost.localdomain (manwe.beleriand.perenold.info [192.168.0.49])
	by perenold.hd.free.fr (Postfix) with ESMTP id 6C16625C
	for <linux-acpi@vger.kernel.org>; Sat, 21 Jan 2006 19:31:28 +0100 (CET)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with ESMTP id 20E6C1C010AB
	for <linux-acpi@vger.kernel.org>; Sat, 21 Jan 2006 19:31:28 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
I've got 4 new ACPI errors during the boot sequence:

ACPI: Subsystem revision 20060113
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI Error (nsxfeval-0240): Handle is NULL and Pathname is relative
ACPI Error (nsxfeval-0240): Handle is NULL and Pathname is relative
ACPI Error (nsxfeval-0240): Handle is NULL and Pathname is relative
ACPI Error (nsxfeval-0240): Handle is NULL and Pathname is relative
...

After some investigations it appears that the corresponding Pathname are
_PR0, _PR1, _PR2 and _PR3 and are concerning the root node.


There is no _PRx in my dsdt so this error has probably always existed but
has been made visible by the switch from ACPI_DEBUG_PRINT to
ACPI_REPORT_ERROR in the latest ACPI patch.

Is this a real error ? Is it OK for my dsdt to lack these _PRx objects  ?

Thanks

(this has already been reported some time ago:
http://marc.theaimsgroup.com/?l=linux-kernel&m=112429158821875&w=2)

(Please CC me)

 

