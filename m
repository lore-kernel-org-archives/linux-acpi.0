From: Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] ACPI / tables: Cleanup the obsolete acpi_parse_entries
Date: Tue, 11 Apr 2017 14:31:32 +0800
Message-ID: <58EC7844.9020401@cn.fujitsu.com>
References: <1491553367-17847-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:42657 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752291AbdDKGWB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Apr 2017 02:22:01 -0400
In-Reply-To: <1491553367-17847-1-git-send-email-bhe@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Baoquan He <bhe@redhat.com>, rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org



On 04/07/2017 04:22 PM, Baoquan He wrote:
> Function acpi_parse_entries is not used any more. And the being used
> function, acpi_table_parse_entries can substitute it if really needed.
> 
> So clean it up in this patch.
> 

It maybe also useful to mention the commit id f26527b142 & 9b3fedde27
who disuse the function.

-- 
Sincerely,
Cao jin



