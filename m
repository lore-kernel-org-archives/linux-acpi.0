From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: What's part of the ABI (breaking eeepc-wmi)
Date: Tue, 8 Feb 2011 14:53:01 +0000
Message-ID: <20110208145301.GA12930@srcf.ucam.org>
References: <AANLkTim5kG-pZRpj+6ckOvuk5ZSJ_O7zbwBnC4JNQPtS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim5kG-pZRpj+6ckOvuk5ZSJ_O7zbwBnC4JNQPtS@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 08, 2011 at 08:51:27AM +0000, Corentin Chary wrote:

> A first solution is to rename eeepc-wmi asus-wmi, and create an alias
> to make eeepc-wmi work. Then this driver would handle asus-wmi and
> eeepc-wmi platform drivers (it could also be splitted in 3
> files/modules, common/notebook/eeepc).
> But then, is it important to keep these strings ?
> - hotplug string ("eeepc-wifi")
> - rfkill names ("eeepc-xxxxx")
> - input strings (.phys and .name)

I think that, realistically, these changes should be fine but may break 
some user code. We don't have a good way of enforcing proper sysfs 
usage.

> - led names ("eeepc::xxxxxx")

But I don't think there's any other way of identifying LEDs, so this 
probably has to stay.

> Any thoughts on that ?

Seems less ugly than the alternatives!

-- 
Matthew Garrett | mjg59@srcf.ucam.org
