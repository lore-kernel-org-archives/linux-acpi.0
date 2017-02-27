From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFC PATCH] mm, hotplug: get rid of auto_online_blocks
Date: Mon, 27 Feb 2017 12:25:10 +0100
Message-ID: <20170227112510.GA4129@osiris>
References: <20170227092817.23571-1-mhocko@kernel.org>
 <87lgssvtni.fsf@vitty.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36437 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752036AbdB0LZc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Feb 2017 06:25:32 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v1RBOCbS025893
        for <linux-acpi@vger.kernel.org>; Mon, 27 Feb 2017 06:25:27 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 28u6waudj5-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-acpi@vger.kernel.org>; Mon, 27 Feb 2017 06:25:27 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-acpi@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 27 Feb 2017 11:25:23 -0000
Content-Disposition: inline
In-Reply-To: <87lgssvtni.fsf@vitty.brq.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, David Rientjes <rientjes@google.com>, Daniel Kiper <daniel.kiper@oracle.com>, linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, Michal Hocko <mhocko@suse.com>

On Mon, Feb 27, 2017 at 11:02:09AM +0100, Vitaly Kuznetsov wrote:
> A couple of other thoughts:
> 1) Having all newly added memory online ASAP is probably what people
> want for all virtual machines.

This is not true for s390. On s390 we have "standby" memory that a guest
sees and potentially may use if it sets it online. Every guest that sets
memory offline contributes to the hypervisor's standby memory pool, while
onlining standby memory takes memory away from the standby pool.

The use-case is that a system administrator in advance knows the maximum
size a guest will ever have and also defines how much memory should be used
at boot time. The difference is standby memory.

Auto-onlining of standby memory is the last thing we want.

> Unfortunately, we have additional complexity with memory zones
> (ZONE_NORMAL, ZONE_MOVABLE) and in some cases manual intervention is
> required. Especially, when further unplug is expected.

This also is a reason why auto-onlining doesn't seem be the best way.

