From: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Date: Mon, 14 Feb 2005 11:58:37 +0100
Message-ID: <20050214105837.GE3233@crusoe.alcove-fr>
References: <20050210161809.GK3493@crusoe.alcove-fr> <E1D0dqo-00041G-00@chiark.greenend.org.uk>
Reply-To: Stelian Pop <stelian@popies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1D0dqo-00041G-00@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 14, 2005 at 10:53:10AM +0000, Matthew Garrett wrote:

> Stelian Pop <stelian@popies.net> wrote:
> 
> > Privately I've had many positive feedbacks from users of this driver
> > (and no negative feedback), including Linux distributions who wish
> > to include it into their kernels. The reports are increasing in number,
> > it would seem that newer Sony Vaios are more and more incompatible
> > with sonypi and require sony_acpi to control the screen brightness.
> 
> The sonypi driver seems to be necessary to catch Vaio hotkey events,
> including the sleep button. I've checked a couple of DSDTs, and it seems
> that the more recent Vaios are lacking the SPIC entries but still don't
> have the sleep button defined. Is there any chance of this driver being
> able to catch hotkey events?

I don't believe so.

> Related to that, I have a nastyish hack which lets the sonypi driver
> generate ACPI events whenever a hotkey is pressed. Despite not strictly
> being ACPI events, this makes it much easier to integrate sonypi stuff
> with general ACPI support. I'll send it if you're interested.

Wouldn't be more useful to make the ACPI hotkeys generate an
input event (like sonypi does) and integrate all this at the input
level ?

Stelian.
-- 
Stelian Pop <stelian@popies.net>
