From: Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: Re: [PATCH] Preserve task state in reentrant calls to ___wait_event
Date: Sat, 7 Nov 2015 08:32:43 +0000
Message-ID: <20151107083243.GA14648@localhost>
References: <20151106204408.GA11609@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34785 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbbKGIcs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2015 03:32:48 -0500
Content-Disposition: inline
In-Reply-To: <20151106204408.GA11609@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, lv.zheng@intel.com, mingo@redhat.com, peterz@infradead.org, rjw@rjwysocki.net, oleg@redhat.com, aystarik@gmail.com

On Fri, Nov 06, 2015 at 08:44:08PM +0000, Chris Bainbridge wrote:
> -#define ___wait_event(wq, condition, state, exclusive, ret, cmd)	\
> +#define ___wait_event(wq, condition, nstate, exclusive, ret, cmd)	\
>  ({									\
>  	__label__ __out;						\
>  	wait_queue_t __wait;						\
>  	long __ret = ret;	/* explicit shadow */			\
> +	long ostate = current->state;					\

XXX

>  									\
>  	INIT_LIST_HEAD(&__wait.task_list);				\
>  	if (exclusive)							\
> @@ -222,16 +223,16 @@ wait_queue_head_t *bit_waitqueue(void *, int);
>  		__wait.flags = 0;					\
>  									\
>  	for (;;) {							\
> -		long __int = prepare_to_wait_event(&wq, &__wait, state);\
> +		long __int = prepare_to_wait_event(&wq, &__wait, nstate);\
>  									\
>  		if (condition)						\
>  			break;						\
>  									\
> -		if (___wait_is_interruptible(state) && __int) {		\
> +		if (___wait_is_interruptible(nstate) && __int) {	\
>  			__ret = __int;					\
>  			if (exclusive) {				\
>  				abort_exclusive_wait(&wq, &__wait,	\
> -						     state, NULL);	\
> +						     nstate, NULL);	\
>  				goto __out;				\
>  			}						\
>  			break;						\
> @@ -240,6 +241,7 @@ wait_queue_head_t *bit_waitqueue(void *, int);
>  		cmd;							\
>  	}								\
>  	finish_wait(&wq, &__wait);					\
> +	set_current_state(ostate);					\

I'm not convinced that this particular code is (or can be) race free in
the general reentrant case. The outer call to ___wait_event will miss 
any wake_up received in the inner call between XXX above (store of
current->state) and this point of restoring the previous state. So if
the inner condition evaluation or some interrupt handler happens to
trigger a wake_up meant for the outer call then it will be lost.

>  __out:	__ret;								\
>  })
