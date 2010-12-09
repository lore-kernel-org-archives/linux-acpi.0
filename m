From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/3] ACPI: Bug compatibility for Windows on the ACPI reboot
 vector
Date: Thu, 09 Dec 2010 14:36:26 -0800
Message-ID: <4D0159EA.90303@zytor.com>
References: <1291931204-5854-1-git-send-email-mjg@redhat.com> <1291931204-5854-3-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59500 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754433Ab0LIWgl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Dec 2010 17:36:41 -0500
In-Reply-To: <1291931204-5854-3-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org

On 12/09/2010 01:46 PM, Matthew Garrett wrote:
> Windows ignores the bit_offset and bit_width, despite the spec requiring
> that they be validated. Drop the checks so that we match this behaviour.
> Windows also goes straight for the keyboard controller if the ACPI reboot
> fails, so we shouldn't sleep if we're still alive.
>
> Signed-off-by: Matthew Garrett<mjg@redhat.com>

Be careful: the goal isn't bug-compatibility with Windows, the goal is 
to work on the maximum number of systems.  Bug-compatibility with 
Windows *may* be a way to that goal, but it is not a guarantee, since 
Windows doesn't get validated against older systems that went through 
WHQL under an earlier version of Windows.

	-hpa
