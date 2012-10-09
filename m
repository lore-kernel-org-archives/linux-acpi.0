From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v4] create sun sysfs file
Date: Tue, 09 Oct 2012 01:05:48 -0400
Message-ID: <5073B0AC.3090601@kernel.org>
References: <502062FB.7030502@jp.fujitsu.com> <503EC30B.2070900@jp.fujitsu.com> <505FC5F1.4090306@jp.fujitsu.com> <506C0B52.4010800@jp.fujitsu.com> <50736885.9010909@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:37230 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab2JIFFu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Oct 2012 01:05:50 -0400
In-Reply-To: <50736885.9010909@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: toshi.kani@hp.com, liuj97@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/08/2012 07:57 PM, Yasuaki Ishimatsu wrote:
> Hi Len,
> 
> What should I do to put this patch in your tree?

Please add a description of the attribute in
Documentation/ABI/testing/

A human needs to understand exactly what is in that file
because you are proposing it as an ABI.

thanks,
Len Brown, Intel Open Source Technology Center


