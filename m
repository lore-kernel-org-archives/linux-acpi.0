From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] acpi: Update battery information on notification 0x81
Date: Tue, 31 Aug 2010 10:06:02 +0100
Message-ID: <AANLkTik620+_nBE+24-ausDet_uhRZD9JmfEV20vy8TU@mail.gmail.com>
References: <1281990739-17912-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46834 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649Ab0HaJGE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Aug 2010 05:06:04 -0400
In-Reply-To: <1281990739-17912-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 16 August 2010 21:32, Matthew Garrett <mjg@redhat.com> wrote:
> A notification event 0x81 from an ACPI battery device requires us to
> re-read the battery information structure. Do so, and if the battery's
> reporting units have changed (as is the case on some Thinkpads) destroy
> and recreate the battery in order to populate the fields correctly.

I've had three reports in upower of this bug (the units changing) so
users are really hitting this in real world usage. As soon as this
kernel fix gets released in a new kernel version I'll remove the
upower workaround. I can't reproduce this myself, so I've not tested
the patch, although the logic is solid in my opinion.

Richard.
