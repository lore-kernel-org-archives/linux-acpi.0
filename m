From: Bruce Laing <blaing@efn.org>
Subject: kdbm_acpi.ko in 2.6?
Date: Mon, 1 May 2006 13:55:09 -0700
Message-ID: <200605011355.09593.blaing@efn.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail1.kalama.com ([204.245.228.16]:51154 "EHLO mail1.kalama.com")
	by vger.kernel.org with ESMTP id S932259AbWEAVD5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 May 2006 17:03:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail1.kalama.com (Postfix) with ESMTP id 5C4AB5B6D0
	for <linux-acpi@vger.kernel.org>; Mon,  1 May 2006 14:03:56 -0700 (PDT)
Received: from mail1.kalama.com ([127.0.0.1])
 by localhost (mail1.kalama.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 08644-06 for <linux-acpi@vger.kernel.org>;
 Mon,  1 May 2006 14:03:56 -0700 (PDT)
Received: from [192.168.1.110] (ten-calix-cust010.tenino.com [12.180.59.10])
	by mail1.kalama.com (Postfix) with ESMTP id 2F9BA5B6CE
	for <linux-acpi@vger.kernel.org>; Mon,  1 May 2006 14:03:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I've seen old references to a loadable module called kdbm_acpi.ko which is 
supposed to provide an interface to the ACPI-CA debugger from the kernel 
debugger, but the 2.6.x kernel sources don't seem to have a drivers/acpi/kdb 
source directory anymore.  Has the kernel debugger ACPI-CA debugger interface 
been moved or removed?

- Bruce
