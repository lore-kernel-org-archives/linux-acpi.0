From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Date: Mon, 14 Feb 2005 10:53:10 +0000
Message-ID: <E1D0dqo-00041G-00@chiark.greenend.org.uk>
References: <20050210161809.GK3493@crusoe.alcove-fr>
In-Reply-To: <20050210161809.GK3493@crusoe.alcove-fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Stelian Pop <stelian@popies.net> wrote:

> Privately I've had many positive feedbacks from users of this driver
> (and no negative feedback), including Linux distributions who wish
> to include it into their kernels. The reports are increasing in number,
> it would seem that newer Sony Vaios are more and more incompatible
> with sonypi and require sony_acpi to control the screen brightness.

The sonypi driver seems to be necessary to catch Vaio hotkey events,
including the sleep button. I've checked a couple of DSDTs, and it seems
that the more recent Vaios are lacking the SPIC entries but still don't
have the sleep button defined. Is there any chance of this driver being
able to catch hotkey events?

Related to that, I have a nastyish hack which lets the sonypi driver
generate ACPI events whenever a hotkey is pressed. Despite not strictly
being ACPI events, this makes it much easier to integrate sonypi stuff
with general ACPI support. I'll send it if you're interested.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
