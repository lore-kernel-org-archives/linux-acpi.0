From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: 2.5.69 - S3
Date: Mon, 19 May 2003 10:53:24 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030519085323.GC130@elf.ucw.cz>
References: <200305140140.02188.mflt1@micrologica.com.hk> <200305182005.30192.mflt1@micrologica.com.hk> <20030518211245.GA452@elf.ucw.cz> <200305191153.51196.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200305191153.51196.mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > and mode 6)
> > >
> > >   System hangs after all tasks left fridge with disk led on.
> > >
> > > I suppose IDE gets false interupt upon resume.
> >
> > Spurious interrupts should be handled gracefully by IDE. On velo I
> > ran my machine with IDE interrupt connected to 1kHz timer, and it
> > more or less worked ("IDE0: spurious interrupt", "Last message
> > repeated 1539 times").
> 
> Cute, Your velo S3 OK (before it died) ? - Do you know of any machines that really work with S3?

I just fixed mtrrs and suspended/resumed that desktop ~10 times... It
seems okay. [Not yet applicable to mainline, I guess, as mtrr is not
in].

								Pavel

--- /usr/src/tmp/linux/arch/i386/kernel/cpu/mtrr/main.c	2003-05-19 10:44:09.000000000 +0200
+++ /usr/src/linux/arch/i386/kernel/cpu/mtrr/main.c	2003-05-19 10:43:10.000000000 +0200
@@ -648,33 +648,33 @@
 };
  
 #ifdef CONFIG_PM
-struct mtrr_suspend_state
-{
+struct mtrr_suspend_one {
 	mtrr_type ltype;
 	unsigned long lbase;
 	unsigned int lsize;
 };
 
-/* We return a pointer ptr on an area of *ptr bytes
-   beginning at ptr+sizeof(int)
-   This buffer has to be saved in some way during suspension */
-static int *mtrr_save_state(void)
+struct mtrr_suspend_state {
+	int len;
+	struct mtrr_suspend_one mtrr[0];
+};
+
+/* This buffer has to be saved in some way during suspension */
+struct mtrr_suspend_state *mtrr_save_state(void)
 {
 	int i, len;
-	int *ptr = NULL;
-	static struct mtrr_suspend_state *mtrr_suspend_buffer=NULL;
+	static struct mtrr_suspend_state *ptr = NULL;
+	static struct mtrr_suspend_one *mtrr_suspend_buffer=NULL;
      
 	if(!mtrr_suspend_buffer)
 	{
-		len = num_var_ranges * sizeof (struct mtrr_suspend_state) + sizeof(int);
+		len = num_var_ranges * sizeof (struct mtrr_suspend_one) + sizeof(int);
 		ptr = kmalloc (len, GFP_KERNEL);
 		if (ptr == NULL)
 			return(NULL);
-		*ptr = len;
-		ptr++;
-		mtrr_suspend_buffer = (struct mtrr_suspend_state *)ptr;
-		ptr--;
+		ptr->len = len;
 	}
+	mtrr_suspend_buffer = &ptr->mtrr;
 	for (i = 0; i < num_var_ranges; ++i,mtrr_suspend_buffer++)
 		mtrr_if->get (i,
 			      &(mtrr_suspend_buffer->lbase),
@@ -684,19 +684,17 @@
 }
 
 /* We restore mtrrs from buffer ptr */
-static void mtrr_restore_state(int *ptr)
+static void mtrr_restore_state(struct mtrr_suspend_state *ptr)
 {
 	int i, len;
-	struct mtrr_suspend_state *mtrr_suspend_buffer;
+	struct mtrr_suspend_one *mtrr_suspend_buffer;
      
-	len = num_var_ranges * sizeof (struct mtrr_suspend_state) + sizeof(int);
-	if(*ptr != len)
-	{
-		printk ("mtrr: Resuming failed due to different number of MTRRs\n");
+	len = num_var_ranges * sizeof (struct mtrr_suspend_one) + sizeof(int);
+	if(ptr->len != len) {
+		printk (KERN_CRIT "mtrr: Resuming failed due to different number of MTRRs\n");
 		return;
 	}
-	ptr++;
-	mtrr_suspend_buffer=(struct mtrr_suspend_state *)ptr;
+	mtrr_suspend_buffer = &ptr->mtrr;
 	for (i = 0; i < num_var_ranges; ++i,mtrr_suspend_buffer++)     
 		if (mtrr_suspend_buffer->lsize)	  
 			set_mtrr(i,
@@ -705,7 +703,7 @@
 				 mtrr_suspend_buffer->ltype);
 }
 
-static void *mtrr_state;
+static struct mtrr_suspend_state *mtrr_state;
 
 static int mtrr_suspend(struct device *dev, u32 state, u32 level)
 {


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
