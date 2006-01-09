From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 09 Jan 2006 01:21:36 +0000
Message-ID: <1136769696.3059.19.camel@localhost>
References: <20060107172446.GA3092@srcf.ucam.org>
	<20060108134744.GA21538@srcf.ucam.org>
	<1136729632.2444.36.camel@localhost>
	<200601090910.24397.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <hal-bounces@lists.freedesktop.org>
In-Reply-To: <200601090910.24397.luming.yu@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/hal>
List-Post: <mailto:hal@lists.freedesktop.org>
List-Help: <mailto:hal-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=subscribe>
Sender: hal-bounces@lists.freedesktop.org
Errors-To: hal-bounces@lists.freedesktop.org
To: Yu Luming <luming.yu@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, desktop_portables@lists.osdl.org, gnome-power-manager-list@gnome.org, hal@lists.freedesktop.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2006-01-09 at 09:10 +0800, Yu Luming wrote:
> >  3. Use the new acpi kernel hotkeys stuff -- not that I really understand
> >  the interface, nor how to use it correctly. Plus I'm not sure how much
> >  of the vendor kernel modules can use this new interface, or if it's
> >  suitable. It all seemed a bit fragile last time I looked.
> 
> Please take a look at 
> http://bugzilla.kernel.org/show_bug.cgi?id=5749
> 
> There are some examples to use hotkey.c for specific laptops with dedicated
> hotkey acpi device objects , and dedicated AML methods.
> This patch: http://bugzilla.kernel.org/show_bug.cgi?id=5749#c3
> can be used to replace sony_acpi.c
> 
> This patch: http://bugzilla.kernel.org/show_bug.cgi?id=5749#c4
> can be used to support brightness control for panasonic laptop.
> 
> This patch: http://bugzilla.kernel.org/show_bug.cgi?id=5749#c5
> can be used to support brighness contrl for ASUS laptop.
> 
> Please notes, I will update these patch against len's testing tree, and 
> ask for inclusion.

Why do we want to use the new hotkey stuff when we can just process all
the events in userspace using acpi events? The hotkey stuff seems
overcomplicated and fragile in my opinion.

Sending and receiving :::data:in:some::odd:format seems a little unusual
to me when we can just listen for the event in one place (like HAL) --
but then maybe I don't understand all the details. It's not like we will
have different programs registering for different acpi button events,
right?

Richard.
