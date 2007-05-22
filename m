From: jamal <hadi@cyberus.ca>
Subject: Re: [PATCH] [-mm] ACPI: export ACPI events via netlink
Date: Tue, 22 May 2007 07:03:45 -0400
Message-ID: <1179831825.4121.30.camel@localhost>
References: <1179827251.7707.29.camel@localhost.localdomain>
Reply-To: hadi@cyberus.ca
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:25637 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116AbXEVLDu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 May 2007 07:03:50 -0400
Received: by wx-out-0506.google.com with SMTP id h29so192069wxd
        for <linux-acpi@vger.kernel.org>; Tue, 22 May 2007 04:03:49 -0700 (PDT)
In-Reply-To: <1179827251.7707.29.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, netdev@vger.kernel.org

Hi Zhang Rui,

Really cool stuff. Can you instead use genetlink?
http://linux-net.osdl.org/index.php/Generic_Netlink_HOWTO 
should help. And if you have more questions post on netdev (not lk).

cheers,
jamal

On Tue, 2007-22-05 at 17:47 +0800, Zhang Rui wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> Export ACPI events via netlink.
> A netlink message is broadcasted when an ACPI event is generated.
> 


