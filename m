From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v6 0/7] PCI: Change assign unassigned resources per root
 bus bassis
Date: Thu, 25 Jul 2013 06:38:16 -0700
Message-ID: <CAE9FiQUyUoFJrHiq_qydvxkxpSqKyK+Y7Cm2-wY8TfTUNPPCnw@mail.gmail.com>
References: <1374529038-14311-1-git-send-email-yinghai@kernel.org>
	<CAErSpo6aXm8_GCSHJcceaimODxpkX4syh4Gd15N-THZ97SGF4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo6aXm8_GCSHJcceaimODxpkX4syh4Gd15N-THZ97SGF4A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 24, 2013 at 3:03 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Rafael, linux-acpi]
> Can you point out again which patch actually fixes Ben's problem?  I
> don't see it mentioned in the changelogs, and I'd like to mention it
> there.

oh, no.

I missed the to put that patch in patches/series.
that one should be really fix the problem for Ben.
others actually are clean up and enhancement when we try to find
solution for the problem.

just resent it
https://patchwork.kernel.org/patch/2833425/

Sorry for that.

You can put that patch in the branch, but we only
need that one for stable (3.10).

Thanks

Yinghai
