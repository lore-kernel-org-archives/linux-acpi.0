From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 04/12] ACPI: EC: Replace atomic variables with bits
Date: Thu, 25 Oct 2007 00:14:22 +0200
Message-ID: <200710250014.22828.rjw@sisk.pl>
References: <20071022101535.2937.79385.stgit@samsung> <20071022101830.2937.52617.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43737 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755234AbXJXV7l (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Oct 2007 17:59:41 -0400
In-Reply-To: <20071022101830.2937.52617.stgit@samsung>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Monday, 22 October 2007 12:18, Alexey Starikovskiy wrote:
> Number of flags is about to be increased, so it is better to
> put them all into bits.
> No functional changes.
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---

Looks ok.

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

>  drivers/acpi/ec.c |   79 +++++++++++++++++++++++++----------------------------
>  1 files changed, 38 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 7b41783..08fbe62 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -65,7 +65,7 @@ enum ec_command {
>  /* EC events */
>  enum ec_event {
>  	ACPI_EC_EVENT_OBF_1 = 1,	/* Output buffer full */
> -	ACPI_EC_EVENT_IBF_0,	/* Input buffer empty */
> +	ACPI_EC_EVENT_IBF_0,		/* Input buffer empty */
>  };
>  
>  #define ACPI_EC_DELAY		500	/* Wait 500ms max. during EC ops */
> @@ -76,6 +76,11 @@ static enum ec_mode {
>  	EC_POLL,		/* Input buffer empty */
>  } acpi_ec_mode = EC_INTR;
>  
> +enum {
> +	EC_FLAGS_WAIT_GPE = 0,		/* Don't check status until GPE arrives */
> +	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
> +};
> +
>  static int acpi_ec_remove(struct acpi_device *device, int type);
>  static int acpi_ec_start(struct acpi_device *device);
>  static int acpi_ec_stop(struct acpi_device *device, int type);
> @@ -116,9 +121,8 @@ static struct acpi_ec {
>  	unsigned long command_addr;
>  	unsigned long data_addr;
>  	unsigned long global_lock;
> +	unsigned long flags;
>  	struct mutex lock;
> -	atomic_t query_pending;
> -	atomic_t event_count;
>  	wait_queue_head_t wait;
>  	struct list_head list;
>  	u8 handlers_installed;
> @@ -148,45 +152,42 @@ static inline void acpi_ec_write_data(struct acpi_ec *ec, u8 data)
>  	outb(data, ec->data_addr);
>  }
>  
> -static inline int acpi_ec_check_status(struct acpi_ec *ec, enum ec_event event,
> -				       unsigned old_count)
> +static inline int acpi_ec_check_status(struct acpi_ec *ec, enum ec_event event)
>  {
> -	u8 status = acpi_ec_read_status(ec);
> -	if (old_count == atomic_read(&ec->event_count))
> +	if (test_bit(EC_FLAGS_WAIT_GPE, &ec->flags))
>  		return 0;
>  	if (event == ACPI_EC_EVENT_OBF_1) {
> -		if (status & ACPI_EC_FLAG_OBF)
> +		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_OBF)
>  			return 1;
>  	} else if (event == ACPI_EC_EVENT_IBF_0) {
> -		if (!(status & ACPI_EC_FLAG_IBF))
> +		if (!(acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF))
>  			return 1;
>  	}
>  
>  	return 0;
>  }
>  
> -static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event,
> -                        unsigned count, int force_poll)
> +static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
>  {
>  	if (unlikely(force_poll) || acpi_ec_mode == EC_POLL) {
>  		unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
> +		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
>  		while (time_before(jiffies, delay)) {
> -			if (acpi_ec_check_status(ec, event, 0))
> +			if (acpi_ec_check_status(ec, event))
>  				return 0;
>  		}
>  	} else {
> -		if (wait_event_timeout(ec->wait,
> -				       acpi_ec_check_status(ec, event, count),
> -				       msecs_to_jiffies(ACPI_EC_DELAY)) ||
> -		    acpi_ec_check_status(ec, event, 0)) {
> +		if (wait_event_timeout(ec->wait, acpi_ec_check_status(ec, event),
> +				       msecs_to_jiffies(ACPI_EC_DELAY)))
> +			return 0;
> +		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
> +		if (acpi_ec_check_status(ec, event)) {
>  			return 0;
> -		} else {
> -			printk(KERN_ERR PREFIX "acpi_ec_wait timeout,"
> -			       " status = %d, expect_event = %d\n",
> -			       acpi_ec_read_status(ec), event);
>  		}
>  	}
> -
> +	printk(KERN_ERR PREFIX "acpi_ec_wait timeout,"
> +			       " status = %d, expect_event = %d\n",
> +			       acpi_ec_read_status(ec), event);
>  	return -ETIME;
>  }
>  
> @@ -196,39 +197,38 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
>  					int force_poll)
>  {
>  	int result = 0;
> -	unsigned count = atomic_read(&ec->event_count);
> +	set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
>  	acpi_ec_write_cmd(ec, command);
>  
>  	for (; wdata_len > 0; --wdata_len) {
> -		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, count, force_poll);
> +		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, force_poll);
>  		if (result) {
>  			printk(KERN_ERR PREFIX
>  			       "write_cmd timeout, command = %d\n", command);
>  			goto end;
>  		}
> -		count = atomic_read(&ec->event_count);
> +		set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
>  		acpi_ec_write_data(ec, *(wdata++));
>  	}
>  
>  	if (!rdata_len) {
> -		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, count, force_poll);
> +		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, force_poll);
>  		if (result) {
>  			printk(KERN_ERR PREFIX
>  			       "finish-write timeout, command = %d\n", command);
>  			goto end;
>  		}
> -	} else if (command == ACPI_EC_COMMAND_QUERY) {
> -		atomic_set(&ec->query_pending, 0);
> -	}
> +	} else if (command == ACPI_EC_COMMAND_QUERY)
> +		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
>  
>  	for (; rdata_len > 0; --rdata_len) {
> -		result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF_1, count, force_poll);
> +		result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF_1, force_poll);
>  		if (result) {
>  			printk(KERN_ERR PREFIX "read timeout, command = %d\n",
>  			       command);
>  			goto end;
>  		}
> -		count = atomic_read(&ec->event_count);
> +		set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
>  		*(rdata++) = acpi_ec_read_data(ec);
>  	}
>        end:
> @@ -261,7 +261,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
>  	/* Make sure GPE is enabled before doing transaction */
>  	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
>  
> -	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, 0, 0);
> +	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, 0);
>  	if (status) {
>  		printk(KERN_ERR PREFIX
>  		       "input buffer is not empty, aborting transaction\n");
> @@ -476,20 +476,18 @@ static void acpi_ec_gpe_query(void *ec_cxt)
>  static u32 acpi_ec_gpe_handler(void *data)
>  {
>  	acpi_status status = AE_OK;
> -	u8 value;
>  	struct acpi_ec *ec = data;
>  
> -	atomic_inc(&ec->event_count);
> +	clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
>  
>  	if (acpi_ec_mode == EC_INTR) {
>  		wake_up(&ec->wait);
>  	}
>  
> -	value = acpi_ec_read_status(ec);
> -	if ((value & ACPI_EC_FLAG_SCI) && !atomic_read(&ec->query_pending)) {
> -		atomic_set(&ec->query_pending, 1);
> -		status =
> -		    acpi_os_execute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
> +	if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_SCI) {
> +		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
> +			status = acpi_os_execute(OSL_EC_BURST_HANDLER,
> +				acpi_ec_gpe_query, ec);
>  	}
>  
>  	return status == AE_OK ?
> @@ -642,8 +640,7 @@ static struct acpi_ec *make_acpi_ec(void)
>  	if (!ec)
>  		return NULL;
>  
> -	atomic_set(&ec->query_pending, 1);
> -	atomic_set(&ec->event_count, 1);
> +	ec->flags = 1 << EC_FLAGS_QUERY_PENDING;
>  	mutex_init(&ec->lock);
>  	init_waitqueue_head(&ec->wait);
>  	INIT_LIST_HEAD(&ec->list);
> @@ -833,7 +830,7 @@ static int acpi_ec_start(struct acpi_device *device)
>  	ret = ec_install_handlers(ec);
>  
>  	/* EC is fully operational, allow queries */
> -	atomic_set(&ec->query_pending, 0);
> +	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
>  	return ret;
>  }
>  
> 
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
