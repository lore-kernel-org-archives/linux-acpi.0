From: Yury Umanets <umka-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>
Subject: os_wait_semaphore()
Date: Fri, 03 Oct 2003 16:37:53 +0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F7D6DA1.9070801@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello all,

I have took a look to acpi_os_wait_semphore() function and realized, 
that the the following code:

                /*
                 * Wait w/ Timeout:
                 * ----------------
                 */
                default:
                // TODO: A better timeout algorithm?
                {
                        int i = 0;
                        static const int quantum_ms = 1000/HZ;
                                                                                        

                        ret = down_trylock(sem);
                        for (i = timeout; (i > 0 && ret < 0); i -= 
quantum_ms) {
                                current->state = TASK_INTERRUPTIBLE;
                                schedule_timeout(1);
                                ret = down_trylock(sem);
                        }
                                                                                        

                        if (ret != 0)
                                status = AE_TIME;
                }
                break;


will behave not very good with Andrea Arcangeli's 2.4.23pre6aa1, where 
some intersting dynamic functionality was introduced. And namely, you 
are able to pass "desktop" or for instnace "HZ=500" as parameter to the 
kernel in lilo or another boot loader. This makes all time slices 
shorter and forces kernel to behave optimally for a desktop machine.

Thus, @quantum_ms will be calculated longer for shorter HZ and this is 
definitelly not good in my opinion. Am I right?

-- 
umka




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
