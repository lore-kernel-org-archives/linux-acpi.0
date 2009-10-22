From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] dell-laptop: Use buffer with 32-bit physical address
Date: Thu, 22 Oct 2009 09:12:16 -0600
Message-ID: <200910220912.17684.bjorn.helgaas@hp.com>
References: <DFEF91B22ED07447AB6AA4B237F913F9039D0A64@ausx3mpc125.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:36399 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666AbZJVPMO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Oct 2009 11:12:14 -0400
In-Reply-To: <DFEF91B22ED07447AB6AA4B237F913F9039D0A64@ausx3mpc125.aus.amer.dell.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stuart_Hayes@dell.com
Cc: linux-acpi@vger.kernel.org, mjg@redhat.com, Rezwanul_Kabir@dell.com

On Wednesday 21 October 2009 01:04:09 pm Stuart_Hayes@dell.com wrote:
> 
> Calls to communicate with system firmware via a SMI (using dcdbas) need
> to use a buffer that has a physical address of 4GB or less.  Currently
> the dell-laptop driver does not guarantee this, and when the buffer
> address is higher than 4GB, the address is truncated to 32 bits and the
> SMI handler writes to the wrong memory address.
> 
> Signed-off-by: Stuart Hayes <stuart_hayes@dell.com>

+static void get_buffer(void)
+{
+	mutex_lock(&buffer_mutex);
+	memset(buffer, 0, sizeof(struct calling_interface_buffer));
+}
+
+static void release_buffer(void)
+{
+	mutex_unlock(&buffer_mutex);
+}


 static int dell_rfkill_set(void *data, bool blocked)
 {
-	struct calling_interface_buffer buffer;
 	int disable = blocked ? 1 : 0;
 	unsigned long radio = (unsigned long)data;
 
 	printk(KERN_WARNING "MATCH, disable is %d\n", disable);
 	printk(KERN_WARNING "MATCH, radio is %x\n", radio);
 
-	memset(&buffer, 0, sizeof(struct calling_interface_buffer));
-	buffer.input[0] = (1 | (radio<<8) | (disable << 16));
-	dell_send_request(&buffer, 17, 11);
+	get_buffer();
+	buffer->input[0] = (1 | (radio<<8) | (disable << 16));
+	dell_send_request(buffer, 17, 11);
+	release_buffer();


I think it would be slightly nicer to do something like this:

    static struct calling_interface_buffer *get_buffer(void);

    static int dell_rfkill_set(void *data, bool blocked)
    {
	struct calling_interface_buffer *buffer;

	buffer = get_buffer();
	...
	release_buffer(buffer);
    }

    static struct calling_interface_buffer *buffer;
    DEFINE_MUTEX(buffer_mutex);

    static struct calling_interface_buffer *get_buffer(void)
    {
	mutex_lock(&buffer_mutex);
	memset(buffer, 0, sizeof(struct calling_interface_buffer));
	return buffer;
    }

because it makes it a little harder to mistakenly use the global
buffer without acquiring the mutex.  With a little work, the
global buffer could probably even be made static to get_buffer(),
to make it *impossible* to get the pointer outside the mutex.

Bjorn
