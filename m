From: David Bronaugh <dbronaugh-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org>
Subject: Re: [PATCH]Panasonic Hotkey Driver v0.5 [2/2]
Date: Fri, 20 Aug 2004 00:44:47 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4125ABEF.9090106@linuxboxen.org>
References: <41244219.1090603@linuxboxen.org> <87acwqserw.wl%miura@da-cha.org>
 <87u0uyqqa7.wl%miura@da-cha.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <87u0uyqqa7.wl%miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hiroshi Miura wrote:

>Hi,
>
>This is incremental bkpatch against pcc_acpi driver v0.4.
>It is made using bkexport.
>
>At Fri, 20 Aug 2004 11:51:31 +0900,
>Hiroshi Miura wrote:
>  
>
>>Hi,
>>
>>I'm also developing lcd brightness driver and clean ups.
>>An infomation of BIOS data is gotten from hardware vendor.
>>
>>These are a little diffence in David's code about bios spec.
>>
>>I want to post my driver soon.
>>    
>>
>
>Hiroshi Miura  --- http://www.da-cha.org/  --- miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org
>NTTDATA Corp. OpenSource Software Center. --- miurahr-3MafRgGXt7BL9jVzuh4AOg@public.gmane.org 
>NTTDATA Intellilink Corp. OpenSource Engineering Dev. -- miurahr-w0OK63jvRlAuJ+9fw/WgBHgSJqDPrsil@public.gmane.org
>Key fingerprint = 9117 9407 5684 FBF1 4063  15B4 401D D077 04AB 8617
>
>  
>
<CUT>

>+static int* sinf;
>+static int num_sifr;
>  
>
Is this really necessary...? Maybe this is just me hating globals.

>+
>+static int
>+acpi_pcc_init_sinf_buffer(void)
> {
>-	int value;
>-	acpi_status status;
>+	acpi_status status = AE_OK;
> 
>-	if (sscanf(buffer, "%i", &value) == 1 && value >= 0 && value < 2) {
>-		if (value == 0) 
>-			/* do nothing */
>-			status = AE_OK;
>-		else {
>-			status = acpi_evaluate_object(0, METHOD_CHGD, 0 , 0);
>-		}
>-		if (ACPI_FAILURE(status)) {
>-			printk(KERN_INFO LOGPREFIX "fail evaluate CHGD()\n");
>-			return -EFAULT;
>-		}
>-	}
>-	return count;
>+	ACPI_FUNCTION_TRACE("acpi_pcc_init_sinf_buffer");
> 
>-}
>+	if (!read_acpi_int(NULL, DEVICE_NAME_HKEY "." METHOD_HKEY_SQTY, &num_sifr)){
>+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "evaluation error HKEY.SQTY\n"));
>+		return_VALUE(-EINVAL);
>+	}
> 
>-static char*
>-read_nothing(char* p)
>-{
>-	/* nothing to do*/
>-	return p;
>+	if ((sinf = (int*)kmalloc(sizeof(int) * (num_sifr + 1), GFP_KERNEL)) == NULL ) {
>+		status = AE_ERROR;
>+	}
>
Doesn't this introduce a memory leak at module unload time? I don't see 
any corresponding kfree()...

<SNIP>

>+static char*
>+acpi_pcc_read_brightness(char* p)
>+{
>+	int i;
>+
>+	if (!acpi_pcc_retrive_biosdata())
>+		return p;
>+
>+	for (i = 2; i < 8 ; i++) {
>+		p += sprintf(p, "%d",	sinf[i]);
>+		switch (i) {
>+		case 2:
>+		case 3:
>+		case 5:
>+		case 6:
>+			p += sprintf(p, ",");
>+			break;
>+		case 4:
>+		case 7:
>+			p += sprintf(p, "\n");
>+			break;
>+		default:
>+			p += sprintf(p, ","); 
>+		}
>+	}
>+	
>  
>
The for loop immediately above could be reduced to:
p += sprintf(p, "%d,%d,%d\n", sinf[2], sinf[3], sinf[4]);
p += sprintf(p, "%d,%d,%d\n", sinf[5], sinf[6], sinf[7]);

<SNIP>

>+static unsigned long
>+acpi_pcc_write_brightness(const char* buffer, unsigned long count)
>+{
>+	int value1, value2;
>+
>+	if (sscanf(buffer, "%i,%i", &value1, &value2) == 2 && value1 >= 0 && value1 < 2 && value2 >=0 && value2 < 20) {
>+		write_sset((value1 == 1)?7:4, value2);
>+	} else
>+		printk("write_brightness error\n");
>+
>+	return count;
>+}
>  
>
Why are there two values for brightness? What do they do?

Thanks in advance,

David Bronaugh


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
