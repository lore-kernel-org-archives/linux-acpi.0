From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] acpi/button: revert v4.10 behavior
Date: Thu, 11 May 2017 02:09:00 +0200
Message-ID: <CAJZ5v0jX82ueSVEHzMZngnJUf=yYJ+TN2efQ0BgwxcQd=bb0_g@mail.gmail.com>
References: <20170510161240.13229-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33163 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbdEKAJB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 May 2017 20:09:01 -0400
In-Reply-To: <20170510161240.13229-1-benjamin.tissoires@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>, Jiri Eischmann <jeischma@redhat.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, May 10, 2017 at 6:12 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> The new default 'open' behavior for acpi_lid_initialize_state() is just
> wrong. It breaks professional laptops with a docking station [1].
>
> Booting the laptop with the LID closed is something common and now there
> is no way of knowing the actual state of the LID switch at boot. Please
> use a user-space solution as described in 2/2 if you really don't want to
> add quirks in the kernel.
>
> Cheers,
> Benjamin
>
> [1] https://bugzilla.gnome.org/show_bug.cgi?id=782380
>
> Benjamin Tissoires (2):
>   Revert "ACPI / button: Remove lid_init_state=method mode"
>   Revert "ACPI / button: Change default behavior to lid_init_state=open"
>
>  Documentation/acpi/acpi-lid.txt | 16 ++++++++++++----
>  drivers/acpi/button.c           | 11 ++++++++++-
>  2 files changed, 22 insertions(+), 5 deletions(-)

Well, have you seen the recent series
(http://marc.info/?l=linux-acpi&m=149431335204701&w=2 and the
following) from Lv?

He evidently agrees with you that "ACPI / button: Remove
lid_init_state=method mode" should be reverted, but then there are
differences.

Can you please have a look at that and let me know what's wrong with
it in your view?  I'd like to have a full picture if poss.

Thanks,
Rafael
