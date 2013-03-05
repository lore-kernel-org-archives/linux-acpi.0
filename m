From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] thinkpad-acpi: fix potential suspend blocking issue
Date: Tue, 5 Mar 2013 18:48:38 +0100
Message-ID: <20130305174838.GA7276@redhat.com>
References: <201303042055.38040.maciej.rutecki@gmail.com> <1362504883-9180-1-git-send-email-msb@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1362504883-9180-1-git-send-email-msb@chromium.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mandeep Singh Baines <msb@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On 03/05, Mandeep Singh Baines wrote:
>
> @@ -2462,13 +2462,13 @@ static int hotkey_kthread(void *data)
>  	unsigned int poll_freq;
>  	bool was_frozen;
>  
> +	set_freezable();
> +
>  	mutex_lock(&hotkey_thread_mutex);
>  
>  	if (tpacpi_lifecycle == TPACPI_LIFE_EXITING)
>  		goto exit;
>  
> -	set_freezable();
> -

I don't understand this code... but don't we have the same problem
with kthread_freezable_should_stop() below? It can call __refrigerator()
too under the same lock.

Oleg.
