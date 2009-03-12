From: Norbert Preining <preining@logic.at>
Subject: help with fixing code for 2.6.29-rc7
Date: Thu, 12 Mar 2009 12:50:32 +0100
Message-ID: <20090312115032.GB26205@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:52524 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbZCLLuq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Mar 2009 07:50:46 -0400
Received: from gamma.logic.tuwien.ac.at ([128.130.175.3] ident=Debian-exim)
	by mx.logic.tuwien.ac.at with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <preining@logic.at>)
	id 1LhjQm-00074j-Tc
	for linux-acpi@vger.kernel.org; Thu, 12 Mar 2009 12:50:32 +0100
Received: from preining by gamma.logic.tuwien.ac.at with local (Exim 4.63)
	(envelope-from <preining@logic.at>)
	id 1LhjQm-0007Hv-Rs
	for linux-acpi@vger.kernel.org; Thu, 12 Mar 2009 12:50:32 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi everyone,

I am trying to fix some code for 2.6.29-rc7:

... acpi_handle handle ...

        struct acpi_namespace_node *node;
        union acpi_operand_object *operand;

1       node = (struct acpi_namespace_node *)handle;
2       operand = (union acpi_operand_object *)node->object;

3       printk(KERN_WARNING DRV_PFX "method: name: %4.4s, args %X\n", node->name.ascii,
4              (u32) operand->method.param_count);

Compiling that I get errors
	error: dereferencing pointer to incomplete type
in line 2,3,4.

Any suggestion how to fix that?

Thanks a lot

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
RUNCORN (n.)
A peeble (q.v.) which is larger that a belper (q.v.)
			--- Douglas Adams, The Meaning of Liff
