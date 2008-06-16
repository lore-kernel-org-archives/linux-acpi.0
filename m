From: Brandon Koepke <bdkoepke@gmail.com>
Subject: Custom SSDT Cpu0Ist and Cpu1Ist
Date: Mon, 16 Jun 2008 15:17:14 -0700
Message-ID: <1213654634.6788.4.camel@brandon-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:37043 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756856AbYFPWRS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jun 2008 18:17:18 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3873914rvb.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jun 2008 15:17:18 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

=EF=BB=BFI have created a custom Cpu0Ist and Cpu1Ist and was wondering =
how I
would go about using it with the kernel. I heard somewhere that you
could just append the data to the end of a DSDT and that would be
enough; however, because using acpidump to get the raw SSDT did not
contain Cpu0Ist and Cpu1Ist I was not sure how to go about this.=20

Thank you for your time.=20

Brandon Koepke.=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
