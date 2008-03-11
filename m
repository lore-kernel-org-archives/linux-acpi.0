From: drago01 <drago01@gmail.com>
Subject: Re: the patch "really disable stray GPEs" breaks battery reading
Date: Tue, 11 Mar 2008 20:38:28 +0100
Message-ID: <f6ca9fed0803111238s1d552c3t3f75e2b285258c71@mail.gmail.com>
References: <f6ca9fed0803110838g5f791f8o68865252759d8356@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:37494 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbYCKTia (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 15:38:30 -0400
Received: by fk-out-0910.google.com with SMTP id z23so2405641fkz.5
        for <linux-acpi@vger.kernel.org>; Tue, 11 Mar 2008 12:38:28 -0700 (PDT)
In-Reply-To: <f6ca9fed0803110838g5f791f8o68865252759d8356@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Chuck Ebbert <cebbert@redhat.com>, rui.zhang@intel.com, lenb@kernel.org

On Tue, Mar 11, 2008 at 4:38 PM, drago01 <drago01@gmail.com> wrote:
> The lastest fedora kernel build has this patch applied, its supposed
>  to fix https://bugzilla.redhat.com/show_bug.cgi?id=251744 and
>  http://bugzilla.kernel.org/show_bug.cgi?id=6217 but it breaks battery
>  reading on my box.
>  See: https://bugzilla.redhat.com/show_bug.cgi?id=436959
>  The data in /proc/acpi/battery is wrong and never changes.
>  I have attached the contents of this files in the bug report noted
>  above. (Its a 12 cell battery)

(adding CCs)
