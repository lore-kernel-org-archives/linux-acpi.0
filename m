From: Gabriel C <nix.or.die@googlemail.com>
Subject: array subscript is above array bounds warnings with gcc4.3
Date: Fri, 04 Apr 2008 19:31:18 +0200
Message-ID: <47F665E6.2010409@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:17372 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbYDDRbY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Apr 2008 13:31:24 -0400
Received: by nf-out-0910.google.com with SMTP id g13so116274nfb.21
        for <linux-acpi@vger.kernel.org>; Fri, 04 Apr 2008 10:31:22 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Gabriel C <crazy@frugalware.org>, netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

Hi,

I noticed these warning on my randconfig logs of some builds :

..

drivers/usb/core/hcd.c: In function 'usb_hcd_poll_rh_status':                                                                                                
include/asm/string_32.h:65: warning: array subscript is above array bounds

net/netfilter/nf_conntrack_proto_sctp.c: In function 'sctp_packet':                                                                                          
net/netfilter/nf_conntrack_proto_sctp.c:374: warning: array subscript is above array bounds

drivers/acpi/tables/tbfadt.c: In function 'acpi_tb_create_local_fadt':                                                                                       
include/asm/string_32.h:65: warning: array subscript is above array bounds

...

Regards,

Gabriel
