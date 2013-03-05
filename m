From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] thinkpad-acpi: fix potential suspend blocking issue
Date: Tue, 5 Mar 2013 20:26:03 -0300
Message-ID: <20130305232603.GA16045@khazad-dum.debian.net>
References: <201303042055.38040.maciej.rutecki@gmail.com>
 <1362504883-9180-1-git-send-email-msb@chromium.org>
 <20130305174838.GA7276@redhat.com>
 <CACBanvqHRDsOQiMsQMw5_QDt1wFrb8_DRoiASSvqeA6XdFrwZQ@mail.gmail.com>
 <20130305180542.GA12738@redhat.com>
 <CACBanvr7XvXbFjphpRwKHHJKzVuA-s6sF-qkPiizBV3+uqzpJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACBanvr7XvXbFjphpRwKHHJKzVuA-s6sF-qkPiizBV3+uqzpJw@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mandeep Singh Baines <msb@chromium.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 05 Mar 2013, Mandeep Singh Baines wrote:
> This mutex seems wrong. Its held the entire time the kthread is
> running. I think its used to synchronize on the exit of the kthread. A
> completion would more appropriate in that case.

>From the top of the driver source:

/* Acquired while the poller kthread is running, use to sync start/stop */
static struct mutex hotkey_thread_mutex;

/*
 * Acquire mutex to write poller control variables as an
 * atomic block.
 *
 * Increment hotkey_config_change when changing them if you
 * want the kthread to forget old state.
 *
 * See HOTKEY_CONFIG_CRITICAL_START/HOTKEY_CONFIG_CRITICAL_END
 */
static struct mutex hotkey_thread_data_mutex;
static unsigned int hotkey_config_change;

#define HOTKEY_CONFIG_CRITICAL_START \
        do { \
                mutex_lock(&hotkey_thread_data_mutex); \
                hotkey_config_change++; \
        } while (0);
#define HOTKEY_CONFIG_CRITICAL_END \
        mutex_unlock(&hotkey_thread_data_mutex);


This can likely be modernized a lot.  This code is from 2008, I think it
first shipped in 2.6.25-rc1.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
