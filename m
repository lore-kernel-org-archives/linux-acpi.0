From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] X86: Revamp reboot behaviour to match Windows more
 closely
Date: Thu, 09 Dec 2010 14:25:05 -0800
Message-ID: <4D015741.7090500@zytor.com>
References: <1291931204-5854-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291931204-5854-1-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 12/09/2010 01:46 PM, Matthew Garrett wrote:
> Windows reboots by hitting the ACPI reboot vector (if available), trying
> the keyboard controller, hitting the ACPI reboot vector again and then
> giving the keyboard controller one last go. Rework our reboot process a
> little to default to matching this behaviour, although we'll fall through
> to attempting a triple fault if nothing else works.
>
> Signed-off-by: Matthew Garrett<mjg@redhat.com>

When this was discussed before we agreed to use ACPI reboot by default 
with an ACPI cutoff date; this doesn't have any such cutoff.

	-hpa
