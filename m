From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] ACPI: Bug compatibility for Windows on the ACPI reboot vector
Date: Thu, 9 Dec 2010 23:41:36 +0100
Message-ID: <201012092341.36260.rjw@sisk.pl>
References: <1291931204-5854-1-git-send-email-mjg@redhat.com> <1291931204-5854-3-git-send-email-mjg@redhat.com> <4D0159EA.90303@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D0159EA.90303@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matthew Garrett <mjg@redhat.com>, x86@kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, December 09, 2010, H. Peter Anvin wrote:
> On 12/09/2010 01:46 PM, Matthew Garrett wrote:
> > Windows ignores the bit_offset and bit_width, despite the spec requiring
> > that they be validated. Drop the checks so that we match this behaviour.
> > Windows also goes straight for the keyboard controller if the ACPI reboot
> > fails, so we shouldn't sleep if we're still alive.
> >
> > Signed-off-by: Matthew Garrett<mjg@redhat.com>
> 
> Be careful: the goal isn't bug-compatibility with Windows, the goal is 
> to work on the maximum number of systems.  Bug-compatibility with 
> Windows *may* be a way to that goal, but it is not a guarantee, since 
> Windows doesn't get validated against older systems that went through 
> WHQL under an earlier version of Windows.

Agreed.

Rafael
