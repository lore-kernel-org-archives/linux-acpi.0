From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: suspend to ram regression from 2.6.28 to 2.6.29-rc2
Date: Mon, 26 Jan 2009 23:21:04 +0100
Message-ID: <497E3750.8030501@dbservice.com>
References: <20090126221554.GA15492@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from office.neopsis.com ([78.46.209.98]:34896 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbZAZWVm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Jan 2009 17:21:42 -0500
In-Reply-To: <20090126221554.GA15492@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 01/26/2009 11:15 PM, Norbert Preining wrote:
> Dear all,
>
> while switching from 2.6.28(-rc*) to 2.6.29-rc2 S2R is completely hosed
> now.
>
> With 2.6.28 I can suspend directly from X and that several times without
> problems.
>
> With 2.6.29-rc2 the following symptoms occur:
> - when suspending from X screen is shut down, but the computer is still
>    running, and it does not react to sysrq
> - when suspending from a minimal boot with all modules unloaded it
>    suspends fine (the power lamp on my laptop flashes slowly red, that is
>    usual and fine), but waking up hangs the computer
>
> It might be related that with 2.6.29-rc2 the intel drm is not activated
> due to a buggy KConfig problem that seems still unfixed. But I don't
> know if that is important.

Try this: http://bugzilla.kernel.org/show_bug.cgi?id=12495#c2
With the four patches (three linked to directly and the one from bug 
12422) I can suspend and resume fine.

tom

