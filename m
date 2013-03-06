From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] thinkpad-acpi: fix potential suspend blocking issue
Date: Wed, 6 Mar 2013 16:50:39 +0100
Message-ID: <20130306155039.GB7697@redhat.com>
References: <201303042055.38040.maciej.rutecki@gmail.com> <1362504883-9180-1-git-send-email-msb@chromium.org> <20130305141817.4e27e83aa66598115e52eb9e@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130305141817.4e27e83aa66598115e52eb9e@linux-foundation.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mandeep Singh Baines <msb@chromium.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Tejun Heo <tj@kernel.org>, Maciej Rutecki <maciej.rutecki@gmail.com>, Artem Savkov <artem.savkov@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On 03/05, Andrew Morton wrote:
>
> Basically the same as
> http://ozlabs.org/~akpm/mmots/broken-out/drivers-platform-x86-thinkpad_acpic-move-hotkey_thread_mutex-lock-after-set_freezable.patch.
>  I think Artem's patch is a little better.  There doesn't appear to be
> any locking protocol for tpacpi_lifecycle.

Which seems to have the same problem, hotkey_kthread() still calls
kthread_freezable_should_stop() under hotkey_thread_mutex.

IOW, we have two try_to_freeze's here, the patch moves only one of
them outside of the hotkey_thread_mutex.

Oleg.
