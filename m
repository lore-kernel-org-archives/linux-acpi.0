From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [KJ] [UPDATE PATCH] acpi/osl: correct HZ dependencies
Date: Wed, 2 Mar 2005 11:59:14 -0800
Message-ID: <20050302195914.GI2741@us.ibm.com>
References: <20050302194821.GG2741@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============23508219160255495=="
In-Reply-To: <20050302194821.GG2741@us.ibm.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/kernel-janitors>
List-Post: <mailto:kernel-janitors@lists.osdl.org>
List-Help: <mailto:kernel-janitors-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.osdl.org?subject=subscribe>
Sender: kernel-janitors-bounces@lists.osdl.org
Errors-To: kernel-janitors-bounces@lists.osdl.org
To: len.brown@intel.com
Cc: Kernel-Janitors <kernel-janitors@lists.osdl.org>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

--===============23508219160255495==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 02, 2005 at 11:48:21AM -0800, Nishanth Aravamudan wrote:
> Hi,
> 
> Please consider applying.
> 
> Description: The osl driver has a few dependencies on HZ which are not
> handled correctly for all values. Use msleep_interruptible() and
> jiffies_to_msecs() to rectify the situation. Patch is compile-tested.

Sorry forgot Signed-off-by line.

Description: The osl driver has a few dependencies on HZ which are not
handled correctly for all values. Use msleep_interruptible() and
jiffies_to_msecs() to rectify the situation. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.11-kj-v/drivers/acpi/osl.c	2005-03-01 23:38:38.000000000 -0800
+++ 2.6.11-kj/drivers/acpi/osl.c	2005-03-02 11:47:34.000000000 -0800
@@ -317,8 +317,7 @@ acpi_os_remove_interrupt_handler(u32 irq
 void
 acpi_os_sleep(acpi_integer ms)
 {
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(((signed long) ms * HZ) / 1000);
+	msleep_interruptible((unsigned int)ms);
 }
 EXPORT_SYMBOL(acpi_os_sleep);
 
@@ -938,7 +937,7 @@ acpi_os_wait_semaphore(
 		// TODO: A better timeout algorithm?
 		{
 			int i = 0;
-			static const int quantum_ms = 1000/HZ;
+			unsigned int quantum_ms = jiffies_to_msecs(1);
 
 			ret = down_trylock(sem);
 			for (i = timeout; (i > 0 && ret < 0); i -= quantum_ms) {

--===============23508219160255495==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Kernel-janitors mailing list
Kernel-janitors@lists.osdl.org
http://lists.osdl.org/mailman/listinfo/kernel-janitors

--===============23508219160255495==--
